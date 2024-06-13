#!/bin/bash

echo "Launch emulator"

${ANDROID_SDK_ROOT}/emulator/emulator -avd testEmu -no-window -noaudio &
EMP=$!

adb wait-for-device

# The device is now booting, or close to be booted
# We just wait until the sys.boot_completed property is set to 1.
echo "Waiting until the device is ready"
while [ "`adb shell getprop sys.boot_completed | tr -d '\r' `" != "1" ] ;
do
  echo "Still waiting for boot.."
  sleep 2;
done

echo "The device is ready"