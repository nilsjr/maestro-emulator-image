FROM eclipse-temurin:21.0.2_13-jdk

LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"
LABEL description="A Docker image allowing to run an Android emulator"
LABEL version="0.0.1"

# Install packages
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install software-properties-common && \
    apt-get -qqy --no-install-recommends install \
    curl \
    zip \
    unzip \
    git \
    locales \
  && rm -rf /var/lib/apt/lists/*

# Arguments
ARG ANDROID_SDK_CMD_TOOLS="commandlinetools-linux-11076708_latest.zip"
ARG API_LEVEL=33

# Use unicode
ENV LANG C.UTF-8

# Set Environment Variables
ENV ANDROID_HOME="/opt/android-sdk" \
    ANDROID_BUILD_TOOLS_VERSION=33.0.2 \
    ARCH=x86_64 \
    TARGET=google_apis

ENV HOME /root

# Now we configure the user account under which we will be running the emulator
RUN mkdir -p $ANDROID_HOME/platforms && \
    mkdir -p $ANDROID_HOME/platform-tools && \
    mkdir -p $ANDROID_HOME/system-images

# Download Android SDK and accept licenses
RUN curl -s -o "$ANDROID_SDK_CMD_TOOLS" "https://dl.google.com/android/repository/$ANDROID_SDK_CMD_TOOLS" \
    && mkdir -p "$ANDROID_HOME/cmdline-tools" \
    && unzip -q "$ANDROID_SDK_CMD_TOOLS" -d "$ANDROID_HOME/cmdline-tools" \
    && rm "$ANDROID_SDK_CMD_TOOLS" \
    && mv "$ANDROID_HOME/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest" \
    && yes | sdkmanager --licenses >/dev/null

# Install Android build tools and platform tools
RUN touch ~/.android/repositories.cfg

RUN sdkmanager --install "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
    platform-tools \
    "system-images;android-$API_LEVEL;$TARGET;$ARCH" \
    "platforms;android-$API_LEVEL" \
    "emulator" \

# Setup path environment variable
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH=$PATH:$ANDROID_HOME/build-tools/latest
ENV PATH=$PATH:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/emulator

#CMD ["bash"]

# Open ADB port
#EXPOSE 5555
#EXPOSE 5556
