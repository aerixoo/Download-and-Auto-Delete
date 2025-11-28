#!/bin/bash

# -------------------------------------------
# LIST OF VIDEO URLs (add as many as you want)
# -------------------------------------------
VIDEO_URLS=(
    "https://cdn3.yesporn.vip/remote_control.php?time=1764343811&cv=5b55ff73baec577ff19096c44ecfbd8a&lr=0&cv2=3e273be04d3697a9a806c712a2b38405&file=%2F57000%2F57851%2F57851_720p.mp4&cv3=c8e86ed5d98c30026dd57f5a89acbdad&cv4=6e6942365d1fd4c5fa8e7f5600c2341d"
    "https://cdn3.yesporn.vip/remote_control.php?time=1764343840&cv=549392dbf164ec9e57ce97c2f126cf53&lr=0&cv2=832055b10a7381e5513894cbe119448a&file=%2F57000%2F57853%2F57853_720p.mp4&cv3=c8e86ed5d98c30026dd57f5a89acbdad&cv4=b4c029ace8fc9748aa5c8d08113b8ac3"
    "https://cdn3.yesporn.vip/remote_control.php?time=1764343856&cv=c0be398f9ea9bf1c62348bf5e0e80c66&lr=0&cv2=fdecde3231e667a6872be28ca09c06a8&file=%2F57000%2F57850%2F57850_720p.mp4&cv3=c8e86ed5d98c30026dd57f5a89acbdad&cv4=1943b3e564965ff6a7aa96f3f8187a47"
)

OUTPUT="video.mp4"
DELAY=5  # seconds between downloads

# -------------------------------------------
# MAIN LOOP
# -------------------------------------------
while true; do
    for VIDEO_URL in "${VIDEO_URLS[@]}"; do

        echo "Downloading: $VIDEO_URL"
        wget -O "$OUTPUT" "$VIDEO_URL"

        # delete only if success
        if [ $? -eq 0 ]; then
            echo "Download successful. Deleting file..."
            rm -f "$OUTPUT"
        else
            echo "Download FAILED. File will NOT be deleted."
        fi

        echo "Waiting $DELAY seconds..."
        sleep $DELAY
    done
done
