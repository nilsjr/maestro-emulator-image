#!/bin/bash

docker build . -f android-emulator-maestro.Dockerfile -t nilsjrfn/maestro-android-emulator-34:latest --platform linux/x86_64
#docker push nilsjrfn/maestro-android-emulator-34:latest