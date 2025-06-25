#!/bin/bash
# -----------------------------------------------------------------------------
# Sunshine Fallback Script (fall_back.sh)
#
# This version uses 'feh' (a fast image viewer) to display a plain
# white image in true, borderless fullscreen, covering all OS UI.
#
# REQUIRES:
# 1. sudo apt install feh
# 2. A white image (create with: convert -size 1920x1080 xc:white /path/to/image.png)
# -----------------------------------------------------------------------------

# --- CONFIGURATION ---
# This is the full path to the white image you created in Step 2.
#WHITE_IMAGE_FILE="/home/leo/Desktop/white_background.png"
WHITE_IMAGE_FILE="/home/leo/Desktop/Loading_icon.gif"

# --- LAUNCH LOGIC ---
echo "[Fallback Script] Starting placeholder image: $WHITE_IMAGE_FILE"

# 1. Kill any previous instances of feh
/usr/bin/pkill -f "feh" 
sleep 0.5 # Give the system a moment to close the old process

# 2. Launch the new fallback screen using feh
#
# -F : Fullscreen
# -Y : Hide mouse pointer
# -N : No filenames (don't show the filename)
# -Z : Auto-zoom image to fill screen
# -B : Background color (set to white just in case)
# &  : Run in the background
#
(/usr/bin/feh -F -Y -N -Z -B white "$WHITE_IMAGE_FILE" &)

# 3. Wait 1 second (feh is much faster than a browser)
echo "[Fallback Script] Waiting 1 second for window to draw..."
sleep 1

echo "[Fallback Script] Placeholder is running. Ready for game launch."
exit 0
