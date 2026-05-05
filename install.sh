#!/usr/bin/env bash
# Claude Code Spinner Verbs — Padova Edition
# "Destrighete, nemo te magna!" — Nonno from Padova

set -euo pipefail

REPO_RAW="${PADOVAN_VERBS_RAW:-https://raw.githubusercontent.com/riccardomerlin/claude-code-spinner-in-padovan/master}"
VERBS_URL="${REPO_RAW}/spinner-verbs.json"
SETTINGS_DIR="${HOME}/.claude"
SETTINGS_FILE="${SETTINGS_DIR}/settings.json"
TMP_VERBS="$(mktemp -t padovan-verbs.XXXXXX.json)"
TMP_MERGED="$(mktemp -t padovan-merged.XXXXXX.json)"

trap 'rm -f "${TMP_VERBS}" "${TMP_MERGED}"' EXIT

c_green() { printf "\033[32m%s\033[0m\n" "$*"; }
c_yellow() { printf "\033[33m%s\033[0m\n" "$*"; }
c_red() { printf "\033[31m%s\033[0m\n" "$*" >&2; }
c_bold() { printf "\033[1m%s\033[0m\n" "$*"; }

require() {
  if ! command -v "$1" >/dev/null 2>&1; then
    c_red "Manca '$1'. Instala prima de ndar vanti."
    exit 1
  fi
}

require curl
require jq

c_bold "Ciao beo! Scarico i verbi padovani..."
if ! curl -fsSL "${VERBS_URL}" -o "${TMP_VERBS}"; then
  c_red "No go catà i verbi. Controla la rete, xe tuto a remengo."
  exit 1
fi

if ! jq -e '.spinnerVerbs.verbs | type == "array"' "${TMP_VERBS}" >/dev/null; then
  c_red "El JSON xe sbrindelà. Sbaglio nel file."
  exit 1
fi

mkdir -p "${SETTINGS_DIR}"

apply_overwrite() {
  cp "${TMP_VERBS}" "${SETTINGS_FILE}"
  c_green "Verbi piantài (overwrite). Destrighete a riaviare Claude Code."
}

apply_merge() {
  jq -s '.[0] * .[1]' "${SETTINGS_FILE}" "${TMP_VERBS}" > "${TMP_MERGED}"
  if ! jq -e '.spinnerVerbs.verbs | type == "array"' "${TMP_MERGED}" >/dev/null; then
    c_red "Merge ndà in ciosso. Nessun canbiamento fato."
    exit 1
  fi
  cp "${TMP_MERGED}" "${SETTINGS_FILE}"
  c_green "Verbi ingrumài (merge). Destrighete a riaviare Claude Code."
}

if [[ -f "${SETTINGS_FILE}" ]]; then
  backup="${SETTINGS_FILE}.bak.$(date +%Y%m%d%H%M%S)"
  cp "${SETTINGS_FILE}" "${backup}"
  c_yellow "Backup salvà: ${backup}"

  c_bold "Settings esistenti catài. Cossa femo?"
  echo "  [m] merge  — tegno el resto, sovrascrivo solo spinnerVerbs"
  echo "  [o] overwrite — sbrego tuto e meto sti verbi"
  echo "  [c] cancel — no toco gnente"
  read -rp "Scegli [m/o/c]: " choice
  case "${choice}" in
    m|M) apply_merge ;;
    o|O) apply_overwrite ;;
    c|C) c_yellow "Anulà. Gnente canbià."; exit 0 ;;
    *) c_red "Risposta no valida. Tajo la corda."; exit 1 ;;
  esac
else
  apply_overwrite
fi

c_bold "Fato! Desso Claude Code el parla padovan. Daghene!"
