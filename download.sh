#!/bin/bash

set -e

URL_FILE="/opt/turbo-downloader/urls.txt"
LOG="/opt/turbo-downloader/downloader.log"
MAX_FAIL=3
PARALLEL=3

echo "[INFO] Auto-refreshing URL list..."
curl -s -L "https://raw.githubusercontent.com/USERNAME/REPO/main/urls.txt" -o "$URL_FILE"

mapfile -t URLS < "$URL_FILE"

declare -A FAIL_COUNT

while true; do
    SHUFFLED=($(printf "%s
" "${URLS[@]}" | shuf))

    printf "%s
" "${SHUFFLED[@]}" | xargs -n 1 -P $PARALLEL -I {} bash -c '
        URL="{}"
        FILE="download_$(date +%s).bin"

        echo "[DOWNLOAD] $URL"
        aria2c -x16 -s16 -o "$FILE" "$URL"

        if [ $? -eq 0 ]; then
            echo "[OK] $URL downloaded → deleting file"
            rm -f "$FILE"
        else
            echo "[FAIL] $URL"
            FAIL_COUNT[$URL]=$((FAIL_COUNT[$URL]+1))

            if [ ${FAIL_COUNT[$URL]} -ge '"$MAX_FAIL"' ]; then
                echo "[SKIP] $URL skipped permanently (failed $MAX_FAIL times)"
            fi
        fi
    ' | tee -a "$LOG"

    sleep 5
done
