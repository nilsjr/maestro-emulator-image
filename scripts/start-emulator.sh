#!/bin/bash

set -e

source ./emulator-monitoring.sh

# The ADB port used to connect to ADB.
AVD_ID=PX34
OPT_MEMORY=${MEMORY:-8192}
OPT_CORES=${CORES:-4}
OPT_SKIP_AUTH=${SKIP_AUTH:-true}
AUTH_FLAG=

if [ "$OPT_SKIP_AUTH" == "true" ]; then
  AUTH_FLAG="-skip-adb-auth"
fi

# If GPU acceleration is enabled, we create a virtual framebuffer
# to be used by the emulator when running with GPU acceleration.
# We also set the GPU mode to `host` to force the emulator to use
# GPU acceleration.
if [ "$GPU_ACCELERATED" == "true" ]; then
  export DISPLAY=":0.0"
  export GPU_MODE="host"
  Xvfb "$DISPLAY" -screen 0 1920x1080x16 -nolisten tcp &
else
  export GPU_MODE="swiftshader_indirect"
fi

# Asynchronously write updates on the standard output
# about the state of the boot sequence.
wait_for_boot &

# Start the emulator with no audio, no GUI, and no snapshots.
echo "Starting the emulator ..."
echo "OPTIONS:"
echo "SKIP ADB AUTH - $OPT_SKIP_AUTH"
echo "GPU           - $GPU_MODE"
echo "MEMORY        - $OPT_MEMORY"
echo "CORES         - $OPT_CORES"
emulator \
  -avd "$AVD_ID" \
  -gpu "$GPU_MODE" \
  -memory $OPT_MEMORY \
  -cores $OPT_CORES \
  $AUTH_FLAG \
  -no-boot-anim \
  -no-window \
  -no-snapshot-save \
  -wipe-data  || update_state "ANDROID_STOPPED"

  # -qemu \
  # -smp 8,sockets=1,cores=4,threads=2,maxcpus=8