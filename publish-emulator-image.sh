#!/bin/bash

# API level passed in as argument
API_LEVEL=$1

docker build . -f android-emulator.Dockerfile --build-arg API_LEVEL=${API_LEVEL} -t nilsjrfn/android-emulator:latest
docker push nilsjrfn/android-emulator:latest