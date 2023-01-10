#!/bin/bash
docker build . -f android-emulator-30.Dockerfile -t nilsjrfn/android-emulator-30:latest
docker push nilsjrfn/android-emulator-30:latest