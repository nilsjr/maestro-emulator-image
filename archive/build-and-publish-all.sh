#!/bin/bash
export API_LEVEL=33

# build base image
docker build . -f android-base.Dockerfile -t nilsjrfn/android-sdk-base:latest --build-arg API_LEVEL=${API_LEVEL}
docker push nilsjrfn/android-sdk-base:latest

# build sdk image
docker build . -f android-sdk.Dockerfile --build-arg API_LEVEL=${API_LEVEL} -t nilsjrfn/android-sdk-${API_LEVEL}:latest
docker push nilsjrfn/android-sdk-$API_LEVEL:latest

# build emulator image
docker build . -f android-emulator.Dockerfile --build-arg API=${API_LEVEL} -t nilsjrfn/android-emulator-${API_LEVEL}:latest
docker push nilsjrfn/android-emulator-$API_LEVEL:latest
