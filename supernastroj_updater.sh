#!/bin/bash
# SuperNastroj Automatic Updater - Enhanced Version

REPO_URL="https://github.com/Fatalerorr69/SuperNastroj.git"
TARGET_DIR="$HOME/SuperNastroj"
BACKUP_DIR="$HOME/SuperNastroj_backup_$(date +%Y%m%d_%H%M%S)"

echo "[*] Kontrola složky SuperNastroj..."

if [ -d "$TARGET_DIR" ]; then
    if [ -d "$TARGET_DIR/.git" ]; then
        echo "[*] Git repozitář existuje, provádím pull..."
        cd "$TARGET_DIR" || exit
        git pull origin main
    else
        echo "[*] Složka existuje, ale není git repozitář."
        echo "[*] Vytvářím zálohu do $BACKUP_DIR ..."
        mv "$TARGET_DIR" "$BACKUP_DIR"
        echo "[*] Klonování repozitáře z GitHubu..."
        git clone "$REPO_URL" "$TARGET_DIR"
    fi
else
    echo "[*] Složka neexistuje, klonování repozitáře..."
    git clone "$REPO_URL" "$TARGET_DIR"
fi

# Přenesení starých pluginů, pokud existují
if [ -d "$BACKUP_DIR/plugins" ]; then
    echo "[*] Přenáším staré pluginy..."
    cp -r "$BACKUP_DIR/plugins/"* "$TARGET_DIR/plugins/"
    chmod +x "$TARGET_DIR/plugins/"*.sh
fi

# Nastavení spustitelnosti updateru a TUI
chmod +x "$TARGET_DIR/supernastroj_updater.sh"
chmod +x "$TARGET_DIR/supernastroj_v5_tui.sh"

# Spuštění updateru a TUI
echo "[*] Spouštím TUI..."
cd "$TARGET_DIR" || exit
./supernastroj_v5_tui.sh
echo "[*] Fully automatic updater dokončen."
