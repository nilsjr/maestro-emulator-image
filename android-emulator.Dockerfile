ARG API_LEVEL

FROM nilsjrfn/android-sdk-$API_LEVEL:latest
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

ENV PATH=$PATH:$ANDROID_HOME/emulator

# Install packages
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install libc++1 \
    curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ARCH=x86_64 \
    TARGET=google_apis

# Install system image
RUN sdkmanager --install "system-images;android-$API_LEVEL;$TARGET;$ARCH" \
    "platforms;android-$API_LEVEL"
RUN sdkmanager --install emulator