#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"
INSTALL_DIR="${HOME}/.local/bin"

SCRIPTS=(tagmp3 ytalbum ytmp3 ytmv)

usage() {
    cat <<EOF
Usage: $(basename "$0") [command]

Commands:
    install     Install/update scripts (default)
    uninstall   Remove symlinks
    status      Show installation status

Scripts will be symlinked to: $INSTALL_DIR
EOF
}

ensure_install_dir() {
    if [[ ! -d "$INSTALL_DIR" ]]; then
        echo "Creating $INSTALL_DIR..."
        mkdir -p "$INSTALL_DIR"
    fi
}

check_path() {
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo ""
        echo "Warning: $INSTALL_DIR is not in your PATH."
        echo "Add this to your shell profile (.bashrc, .zshrc, etc.):"
        echo ""
        echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo ""
    fi
}

install_scripts() {
    ensure_install_dir

    echo "Installing scripts to $INSTALL_DIR..."
    echo ""

    for script in "${SCRIPTS[@]}"; do
        src="$BIN_DIR/$script"
        dest="$INSTALL_DIR/$script"

        if [[ ! -f "$src" ]]; then
            echo "  Warning: $script not found in bin/"
            continue
        fi

        if [[ -L "$dest" ]]; then
            rm "$dest"
        elif [[ -e "$dest" ]]; then
            echo "  Backing up existing $script to ${script}.bak"
            mv "$dest" "${dest}.bak"
        fi

        ln -s "$src" "$dest"
        echo "  Linked: $script"
    done

    echo ""
    echo "Done."
    check_path
}

uninstall_scripts() {
    echo "Removing scripts from $INSTALL_DIR..."
    echo ""

    for script in "${SCRIPTS[@]}"; do
        dest="$INSTALL_DIR/$script"

        if [[ -L "$dest" ]]; then
            rm "$dest"
            echo "  Removed: $script"
        elif [[ -e "$dest" ]]; then
            echo "  Skipped: $script (not a symlink)"
        else
            echo "  Not found: $script"
        fi
    done

    echo ""
    echo "Done."
}

show_status() {
    echo "Installation status:"
    echo ""

    for script in "${SCRIPTS[@]}"; do
        dest="$INSTALL_DIR/$script"

        if [[ -L "$dest" ]]; then
            target="$(readlink "$dest")"
            echo "  $script -> $target"
        elif [[ -e "$dest" ]]; then
            echo "  $script (exists, not a symlink)"
        else
            echo "  $script (not installed)"
        fi
    done
}

case "${1:-install}" in
    install)
        install_scripts
        ;;
    uninstall)
        uninstall_scripts
        ;;
    status)
        show_status
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 1
        ;;
esac
