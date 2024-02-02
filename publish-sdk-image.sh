#!/bin/bash

# API level passed in as argument
API_LEVEL=$1

docker build . -f android-sdk.Dockerfile --build-arg API_LEVEL=${API_LEVEL} -t nilsjrfn/android-sdk-${API_LEVEL}:latest --platform linux/x86_64
docker push nilsjrfn/android-sdk-${API_LEVEL}:latest