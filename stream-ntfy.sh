#!/bin/bash

# DOWNLOAD M3U FILE
wget --no-hsts -O /tmp/streams.m3u "$M3U_URL"

# SET M3U VARIABLE
M3U_FILE="/tmp/streams.m3u"

# LOOP TO TEST WHETHER STREAMS ARE UP/DOWN
echo "TESTING STREAMS..."
echo "=================="

while IFS= read -r line; do
    # SKIP METADATA AND EMPTY LINES
    [[ "$line" =~ ^# ]] && continue
    [[ -z "$line" ]] && continue
    # CLEANUP URL LINES
    line="${line%$'\r'}"
    line="${line##+([[:space:]])}"
    line="${line%%+([[:space:]])}"
    # CHECK WHETHER STREAM IS UP/DOWN
    if ffprobe -v error -timeout "5000000" -analyzeduration "2000000" -show_entries format=format_name -of default=noprint_wrappers=1 -allowed_extensions ALL -allowed_segment_extensions ALL -extension_picky 0 "$line" > /dev/null 2>&1; then
        echo "🟢 $line"
        sleep 5
    # IF STREAM IS DOWN RECHECK
    else
        if ffprobe -v error -timeout "3000000" -analyzeduration "1500000" -show_entries format=format_name -of default=noprint_wrappers=1 -allowed_extensions ALL -allowed_segment_extensions ALL -extension_picky 0 "$line" > /dev/null 2>&1; then
            echo "🟢 $line"
            sleep 5
        else
            echo "🔴 $line"
            curl -s -o /dev/null -H 'Title: STREAM DOWN' -d "🔴 $line"  "$NTFY_URL"
        fi
    fi
done < "$M3U_FILE"

echo "=================="
echo "TESTING COMPLETE!"
