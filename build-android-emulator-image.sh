#!/bin/bash

docker build . -f android-emulator.Dockerfile -t nilsjrfn/android-emulator-34:latest --platform linux/x86_64
#docker push nilsjrfn/android-emulator-34:latest