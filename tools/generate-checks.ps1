$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)

$common = @'
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
'@

$challenges = @(
    @{ Id = "bof-vizinho"; Answer = "resposta-1.txt"; Digest = "e0738c23d17299778bbedfac098b912ec61cdb3a1c0491d6969b92deeb1af5ce"; Regex = '^0x[0-9a-f]{8}$' },
    @{ Id = "pilha-lifo"; Answer = "resposta-2.txt"; Digest = "6d2e6412648dc30aa762c8b6923dde36137d98bf1111424dd151466927e82e20"; Regex = '^[0-9,]+;[0-9]+$' },
    @{ Id = "shellcode-exit"; Answer = "resposta-3.txt"; Digest = "73f3eccf1e6a68c84444db56ae9dd4e7cf5d79aeb1ae9a3c673222ae12f8b70e"; Regex = '^[0-9a-f]+$' },
    @{ Id = "eip-sobrescrita"; Answer = "resposta-4.txt"; Digest = "520bd27a0f66fe241d961569693707946d1c6f8eae1aee190af2a9c997ffeff9"; Regex = '^0x[0-9a-f]{8}$' },
    @{ Id = "bof-offset"; Answer = "resposta-5.txt"; Digest = "c7c4f94a01c5fff8e92122e187332ab2c23882d00f4381d065d98a84168a2067"; Regex = '^[0-9]{1,3}$' },
    @{ Id = "pilha-rsp"; Answer = "resposta-6.txt"; Digest = "3b4e5f1befa3f069c4a85c4b248a445d64816881f8caa4d7f1ce654bf89c2e06"; Regex = '^[0-9]{1,3}$' },
    @{ Id = "shellcode-exit42"; Answer = "resposta-7.txt"; Digest = "86723d5730cccb2c9185260b8774f2e84fca6eba9a50385b7acc5d759618b407"; Regex = '^[0-9a-f]+$' },
    @{ Id = "eip-ret2win"; Answer = "resposta-8.txt"; Digest = "6504417d7223193e7346ad3b917aa049707eff7a345711281f55010025727eca"; Regex = '^[a-z_][a-z0-9_]*$' },
    @{ Id = "bof-ret2win"; Answer = "resposta-9.txt"; Digest = "7338fc5c32506694d4770bf26756d3f7ab24462c2235e41cf1f65ae0a32351c9"; Regex = '^[a-z_][a-z0-9_]*$' },
    @{ Id = "pilha-call-ret"; Answer = "resposta-10.txt"; Digest = "9c2bff97c0048fd1e66842c5e2da8d9d9e7d7297e7d003978dfca4b510f88815"; Regex = '^[a-z-]+$' }
)

$index = 1
foreach ($challenge in $challenges) {
    $folder = Join-Path $root "exercicio-$index\$($challenge.Id)"
    if (-not (Test-Path $folder)) {
        throw "Diretorio do desafio nao encontrado: $folder"
    }

    $wrapper = @"
#!/usr/bin/exec-suid -- /bin/bash -p
set -euo pipefail
CHALLENGE_ID="$($challenge.Id)"
source /challenge/check-common.sh
check_answer "/home/hacker/$($challenge.Answer)" "$($challenge.Digest)" '$($challenge.Regex)'
"@
    [IO.File]::WriteAllText((Join-Path $folder "check-common.sh"), $common, $utf8)
    [IO.File]::WriteAllText((Join-Path $folder "check"), $wrapper + "`n", $utf8)
    $index++
}

Write-Output "Gerados os verificadores para $($challenges.Count) desafios."
