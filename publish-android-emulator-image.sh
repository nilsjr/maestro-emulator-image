#!/bin/bash

docker build . -f android-emulator.Dockerfile -t nilsjrfn/android-emulator-34:latest
docker push nilsjrfn/android-emulator-34:latest