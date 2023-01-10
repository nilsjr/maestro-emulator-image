#!/bin/bash

docker build . -f android-base.Dockerfile -t nilsjrfn/android-sdk-base:latest

docker push nilsjrfn/android-sdk-base:latest