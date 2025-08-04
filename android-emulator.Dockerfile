FROM eclipse-temurin:21.0.8_9-jdk

ENV DEBIAN_FRONTEND noninteractive

#WORKDIR /
#=============================
# Install Dependenices
#=============================

RUN apt update && apt install -y curl \
	sudo wget unzip bzip2 git libdrm-dev \
	libxkbcommon-dev libgbm-dev libasound-dev libnss3 \
	libxcursor1 libpulse-dev libxshmfence-dev \
	xauth xvfb x11vnc fluxbox wmctrl libdbus-glib-1-2 socat \
	virt-manager


# Docker labels.
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"
LABEL description="A Docker image to build and run android tests on emulator"
LABEL version="0.0.1"


# Arguments that can be overriden at build-time.
ARG INSTALL_ANDROID_SDK=1
ARG API_LEVEL=33
ARG IMG_TYPE=google_apis
ARG ARCHITECTURE=x86_64
ARG CMD_LINE_VERSION=11076708_latest
ARG DEVICE_ID=pixel
ARG AVD_ID=Pixel2
ARG GPU_ACCELERATED=false

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
	ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=10 \
	ANDROID_AVD_HOME=/data

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
	touch /root/.android/repositories.cfg && \
	mkdir /data

# Exporting ADB keys.
COPY keys/* /root/.android/

# Copy the container scripts in the image.
COPY scripts/install-sdk.sh /opt/
COPY scripts/create-emulator.sh /opt/
COPY scripts/start-emulator.sh /opt/
COPY scripts/emulator-monitoring.sh /opt/

RUN chmod +x /opt/*.sh
RUN /opt/install-sdk.sh
RUN /opt/create-emulator.sh

COPY EmulatorConfig.ini /.android/avd/${AVD_ID}.avd/config.ini

# Set the entrypoint
ENTRYPOINT ["/opt/start-emulator.sh"]