#!/bin/bash

echo "Create AVD"

CMD_SM_PATH=$(which sdkmanager)
CMD_AM_PATH=${CMD_SM_PATH/sdkmanager/avdmanager}

echo $CMD_AM_PATH

ARCH=$(uname -m)
echo $ARCH

if [ "$ARCH" = "arm64" ]; then
  EMU_ARCH="arm64-v8a"
else
  EMU_ARCH="x86_64"
fi

EMU_ARCH="x86"

# sdkmanager --install "system-images;android-30;google_apis;${EMU_ARCH}"

$CMD_AM_PATH --verbose create avd --name "testEmu" --package "system-images;android-30;google_apis;${EMU_ARCH}" --tag "google_apis" --abi "${EMU_ARCH}" --device "pixel_5"

echo "AVD testEmu created"