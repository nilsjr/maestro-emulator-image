FROM eclipse-temurin:21.0.3_9-jdk

# Docker labels.
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"
LABEL description="A Docker image to build and run android tests on emulator"
LABEL version="0.0.1"

# Installing required packages.
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install software-properties-common \
    curl \
    zip \
    unzip \
    git \
    locales \
  && rm -rf /var/lib/apt/lists/*

# Arguments that can be overriden at build-time.
ARG API_LEVEL=33
ARG ARCHITECTURE=x86_64
ARG CMD_LINE_VERSION=11076708_latest
ARG DEVICE_ID=pixel
ARG GPU_ACCELERATED=false
ARG IMG_TYPE=google_apis
ARG INSTALL_ANDROID_SDK=1

# Environment variables.
ENV ANDROID_SDK_ROOT=/opt/android \
    ANDROID_PLATFORM_VERSION="platforms;android-$API_LEVEL" \
    PACKAGE_PATH="system-images;android-${API_LEVEL};${IMG_TYPE};${ARCHITECTURE}" \
    API_LEVEL=$API_LEVEL \
		DEVICE_ID=$DEVICE_ID \
    ARCHITECTURE=$ARCHITECTURE \
    ABI=${IMG_TYPE}/${ARCHITECTURE} \
    GPU_ACCELERATED=$GPU_ACCELERATED \
    QTWEBENGINE_DISABLE_SANDBOX=1 \
    ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=10

# Exporting environment variables to keep in the path
# Android SDK binaries and shared libraries.
ENV PATH "${PATH}:${ANDROID_SDK_ROOT}/platform-tools"
ENV PATH "${PATH}:${ANDROID_SDK_ROOT}/emulator"
ENV PATH "${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin"
ENV LD_LIBRARY_PATH "$ANDROID_SDK_ROOT/emulator/lib64:$ANDROID_SDK_ROOT/emulator/lib64/qt/lib"

# Set the working directory to /opt
WORKDIR /opt

# Exposing the Android emulator console port
# and the ADB port.
EXPOSE 5554 5555

# Initializing the required directories.
RUN mkdir /root/.android/ && \
	touch /root/.android/repositories.cfg

COPY install-sdk.sh /opt/
RUN chmod +x /opt/install-sdk.sh
RUN /opt/install-sdk.sh

CMD [ "/bin/bash" ]
