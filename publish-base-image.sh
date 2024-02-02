#!/bin/bash

docker build . -f android-base.Dockerfile -t nilsjrfn/android-sdk-base:latest --platform linux/x86_64
docker push nilsjrfn/android-sdk-base:latest