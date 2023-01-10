#!/bin/bash
docker build . -f android-sdk-30.Dockerfile -t nilsjrfn/android-sdk-30:latest
docker push nilsjrfn/android-sdk-30:latest