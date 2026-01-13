#!/usr/bin/env bash
set -euo pipefail

# ==========================================================
# historydns installer
# ==========================================================

BIN_NAME="historydns"
REPO_RAW="REPO_RAW="https://raw.githubusercontent.com/deivy-ramirez/historydns-cli/main""

TARGET_DIR="$HOME/bin"
TARGET_PATH="$TARGET_DIR/$BIN_NAME"

# --------------------------
# Helpers
# --------------------------
log()  { echo "▶ $*"; }
ok()   { echo "✔ $*"; }
warn() { echo "⚠ $*"; }
err()  { echo "✖ $*" >&2; exit 1; }

# --------------------------
# Checks
# --------------------------
command -v curl >/dev/null 2>&1 || err "curl no está instalado"

# --------------------------
# Install
# --------------------------
log "Creando directorio $TARGET_DIR"
mkdir -p "$TARGET_DIR"

log "Descargando $BIN_NAME..."
curl -fsSL "$REPO_RAW/$BIN_NAME" -o "$TARGET_PATH"

log "Asignando permisos de ejecución"
chmod +x "$TARGET_PATH"

# --------------------------
# PATH setup (safe)
# --------------------------
PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'

add_path_if_missing() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  grep -Fqs "$PATH_LINE" "$file" || echo "$PATH_LINE" >> "$file"
}

add_path_if_missing "$HOME/.zshrc"
add_path_if_missing "$HOME/.bashrc"
add_path_if_missing "$HOME/.profile"

export PATH="$HOME/bin:$PATH"

# --------------------------
# Done
# --------------------------
ok "$BIN_NAME instalado correctamente"
echo
echo "Uso:"
echo "  historydns dominio.com"
echo
echo "Si el comando no se reconoce:"
echo "  cierra y abre la terminal"
echo "  o ejecuta: source ~/.zshrc"
echo
echo "Credenciales CIRCL:"
echo "  export CIRCL_USER=\"tu_usuario\""
echo "  export CIRCL_PASS=\"tu_password\""
