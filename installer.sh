#!/bin/bash

set -e

echo "=============================="
echo "   Downloader Auto-Installer"
echo "=============================="

sudo apt-get update -y
sudo apt-get install -y aria2 curl nano xargs

INSTALL_DIR="/opt/turbo-downloader"
sudo mkdir -p "$INSTALL_DIR"
sudo chmod -R 777 "$INSTALL_DIR"

RAW_BASE="https://raw.githubusercontent.com/aerixoo/Download-and-Auto-Delete/main/download.sh"

curl -s -L "$RAW_BASE/download.sh" -o "$INSTALL_DIR/download.sh"
chmod +x "$INSTALL_DIR/download.sh"

curl -s -L "$RAW_BASE/urls.txt" -o "$INSTALL_DIR/urls.txt"

echo "#!/bin/bash
bash $INSTALL_DIR/download.sh" | sudo tee /usr/local/bin/turbo-dl >/dev/null

sudo chmod +x /usr/local/bin/turbo-dl

echo "=============================="
echo "INSTALL DONE — Run: turbo-dl"
echo "=============================="
