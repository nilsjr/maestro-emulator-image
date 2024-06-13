#!/bin/bash

docker build . -f emulator-33.Dockerfile -t nilsjrfn/android-emulator-33:latest
docker push nilsjrfn/android-emulator-33:latest