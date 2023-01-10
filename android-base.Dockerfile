FROM eclipse-temurin:17-jdk
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

ARG ANDROID_SDK_CMD_TOOLS="commandlinetools-linux-8512546_latest.zip"

# Set Environment Variables
ENV ANDROID_SDK_ROOT="/opt/android-sdk"
ENV ANDROID_HOME="/opt/android-sdk"
ENV ANDROID_BUILD_TOOLS_VERSION=33.0.1
# Setup path environment variable
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/build-tools/latest:$ANDROID_HOME/platform-tools
ENV HOME /root

# Download required packages
RUN apt-get update -q \
    && apt-get install --no-install-recommends --no-upgrade -q -y curl unzip git openssh-client jq

# Now we configure the user account under which we will be running the emulator
RUN mkdir -p /opt/android-sdk/platforms && \
    mkdir -p /opt/android-sdk/platform-tools && \
    mkdir -p /opt/android-sdk/system-images

# Download Android SDK and accept licenses
RUN curl -s -o "$ANDROID_SDK_CMD_TOOLS" "https://dl.google.com/android/repository/$ANDROID_SDK_CMD_TOOLS" \
    && mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools" \
    && unzip -q "$ANDROID_SDK_CMD_TOOLS" -d "$ANDROID_SDK_ROOT/cmdline-tools" \
    && rm "$ANDROID_SDK_CMD_TOOLS" \
    && mv "$ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools" "$ANDROID_SDK_ROOT/cmdline-tools/latest" \
    && yes | sdkmanager --licenses >/dev/null

# Install Android build tools and platform tools
RUN touch ~/.android/repositories.cfg
RUN sdkmanager --install "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
    "platform-tools"

# Install packages
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install libc++1 \
    curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install maestro
RUN curl -Ls 'https://get.maestro.mobile.dev' | bash
ENV PATH=$PATH:$HOME/.maestro/bin