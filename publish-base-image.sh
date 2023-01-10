#!/bin/bash

# build docker image
docker build . -f android-base.Dockerfile -t nilsjrfn/android-sdk-base:latest

# publish to docker
docker push nilsjrfn/android-sdk-base:latest