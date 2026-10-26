#!/usr/bin/env bash
set -euo pipefail

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH
trap '' INT QUIT TSTP HUP

fail_internal() {
    echo "Erro interno do verificador ($1). Avise o professor."
    exit 2
}

as_student() {
    setpriv --reuid="$STUDENT_UID" --regid="$STUDENT_GID" --clear-groups -- "$@"
}

is_root_directory() {
    [ -d "$1" ] && [ ! -L "$1" ] && [ "$(stat -c %u -- "$1")" = 0 ]
}

open_attempt_record() {
    command -v setpriv >/dev/null || fail_internal "setpriv ausente"
    command -v sha256sum >/dev/null || fail_internal "sha256sum ausente"
    STUDENT_UID=$(id -u hacker) || fail_internal "usuario hacker"
    STUDENT_GID=$(id -g hacker) || fail_internal "grupo hacker"

    if [ -e "$STATE_DIR" ] || [ -L "$STATE_DIR" ]; then
        if ! is_root_directory "$STATE_DIR"; then
            quarantine="$STATE_DIR.descartado.$$.$RANDOM"
            mv -T -- "$STATE_DIR" "$quarantine" || fail_internal "isolar diretorio adulterado"
        elif [ ! -f "$STATE_DIR/$STATE_MARKER" ] ||
             [ "$(stat -c %u -- "$STATE_DIR/$STATE_MARKER")" != 0 ]; then
            fail_internal "marcador do registro ausente"
        fi
    fi

    if [ ! -e "$STATE_DIR" ]; then
        candidate=""
        while IFS= read -r -d '' directory; do
            if [ -f "$directory/$STATE_MARKER" ] &&
               [ "$(stat -c %u -- "$directory/$STATE_MARKER")" = 0 ]; then
                candidate="$directory"
                break
            fi
        done < <(find "$STUDENT_HOME" -mindepth 1 -maxdepth 1 -type d -user root -print0)

        if [ -n "$candidate" ]; then
            mv -T -- "$candidate" "$STATE_DIR" || fail_internal "recuperar registro"
        else
            mkdir -m 700 -- "$STATE_DIR" || fail_internal "criar registro"
            chown 0:0 -- "$STATE_DIR" || fail_internal "proteger registro"
            : > "$STATE_DIR/$STATE_MARKER" || fail_internal "criar marcador"
            chown 0:0 -- "$STATE_DIR/$STATE_MARKER" || fail_internal "proteger marcador"
            chmod 600 -- "$STATE_DIR/$STATE_MARKER" || fail_internal "permissoes do marcador"
        fi
    fi

    is_root_directory "$STATE_DIR" || fail_internal "diretorio do registro"
    [ -f "$STATE_DIR/$STATE_MARKER" ] &&
        [ "$(stat -c %u -- "$STATE_DIR/$STATE_MARKER")" = 0 ] ||
        fail_internal "marcador do registro"

    exec 9>"$STATE_DIR/.lock" || fail_internal "abrir trava"
    flock -x 9 || fail_internal "travar registro"

    STATE_FILE="$STATE_DIR/$CHALLENGE_ID"
    local status=""
    if [ -f "$STATE_FILE" ] && [ "$(stat -c %u -- "$STATE_FILE")" = 0 ]; then
        status=$(cat -- "$STATE_FILE") || fail_internal "ler registro"
    fi

    case "$status" in
        aprovado)
            echo "Desafio ja concluido. Flag:"
            cat /flag || fail_internal "ler flag"
            exit 0
            ;;
        invalido)
            echo "DESAFIO INVALIDADO: voce ja errou duas vezes."
            echo "A flag deste desafio nao sera liberada."
            exit 1
            ;;
        ""|erros=0|erros=1)
            ERRORS="${status#erros=}"
            [ -n "$ERRORS" ] || ERRORS=0
            ;;
        *)
            fail_internal "estado inconsistente"
            ;;
    esac
}

write_state() {
    local value="$1"
    local temporary="$STATE_DIR/.$CHALLENGE_ID.$$"

    printf '%s\n' "$value" > "$temporary" || fail_internal "gravar estado"
    chown 0:0 -- "$temporary" || fail_internal "proteger estado"
    chmod 600 -- "$temporary" || fail_internal "permissoes do estado"
    mv -fT -- "$temporary" "$STATE_FILE" || fail_internal "atualizar estado"
}

reject_answer() {
    local next=$((ERRORS + 1))
    if [ "$next" -ge 2 ]; then
        write_state "invalido"
    else
        write_state "erros=$next"
    fi

    echo "Resposta incorreta."
    if [ "$next" -ge 2 ]; then
        echo "DESAFIO INVALIDADO: esta foi sua segunda resposta errada."
        echo "A flag deste desafio nao sera liberada."
    else
        echo "ATENCAO: voce ainda tem uma tentativa."
        echo "Revise a resposta antes de executar o check novamente."
    fi
    exit 1
}

check_answer() {
    local answer_path="$1"
    local expected_sha="$2"
    local format_regex="$3"
    local raw normalized
    local -a lines=()

    open_attempt_record

    if ! as_student test -f "$answer_path"; then
        echo "Arquivo $answer_path nao encontrado (nao conta como tentativa)."
        exit 1
    fi

    local byte_count invalid_bytes
    byte_count=$(as_student stat -c %s -- "$answer_path") || {
        echo "Resposta ilegivel (nao conta como tentativa)."
        exit 1
    }
    if [ "$byte_count" -gt 4096 ]; then
        echo "Resposta maior que 4096 bytes (nao conta como tentativa)."
        exit 1
    fi

    invalid_bytes=$(as_student cat -- "$answer_path" |
        tr -d '\11\12\15\40-\176' |
        wc -c) || {
        echo "Resposta ilegivel (nao conta como tentativa)."
        exit 1
    }
    if [ "$invalid_bytes" -ne 0 ]; then
        echo "Resposta deve conter somente texto ASCII (nao conta como tentativa)."
        exit 1
    fi

    raw=$(as_student head -c 4097 -- "$answer_path") || {
        echo "Resposta ilegivel (nao conta como tentativa)."
        exit 1
    }
    normalized=$(printf '%s' "$raw" |
        tr '[:upper:]' '[:lower:]' |
        tr -d ' \t\r' |
        sed '/^$/d') || fail_internal "normalizar resposta"
    [ -n "$normalized" ] && mapfile -t lines <<< "$normalized"

    if [ "${#lines[@]}" -ne 1 ] || ! [[ "${lines[0]:-}" =~ $format_regex ]]; then
        echo "Formato invalido (nao conta como tentativa)."
        echo "Use uma unica linha no formato solicitado na descricao."
        exit 1
    fi

    local actual_sha
    actual_sha=$(printf '%s\n%s' "$CHALLENGE_ID" "${lines[0]}" | sha256sum | cut -d' ' -f1) ||
        fail_internal "calcular hash da resposta"
    if [ "$actual_sha" = "$expected_sha" ]; then
        write_state "aprovado"
        echo "Correto! Flag:"
        cat /flag || fail_internal "ler flag"
        exit 0
    fi

    reject_answer
}

STUDENT_HOME="/home/hacker"
STATE_DIR="$STUDENT_HOME/.tentativas"
STATE_MARKER=".registro-pwn-tentativas"