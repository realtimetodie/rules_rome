#!/usr/bin/env bash

set -o pipefail -o errexit -o nounset

function logf_stderr {
    local format_string="$1\n"
    printf "$format_string" "$@" >&2
}

function logf_fatal {
    printf "FATAL: " >&2
    logf_stderr "$@"
}

if [ ! -f "{{rome}}" ]; then
    logf_fatal "rome binary '%s' not found in runfiles" "{{rome}}"
    exit 1
fi
if [ ! -x "{{rome}}" ]; then
    logf_fatal "rome binary '%s' is not executable" "{{rome}}"
    exit 1
fi

{{rome}} {{command}} {{options}}
