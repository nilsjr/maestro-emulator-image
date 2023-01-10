FROM nilsjrfn/android-sdk-30:latest
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

# Install packages
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install libc++1 \
    curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sdkmanager --list | grep system-images

# Install system images
#ENV ARCH=x86_64 \
#    TARGET=google_apis \
#    EMULATOR_API_LEVEL=30

# API 30 system image
#RUN sdkmanager --install "system-images;android-${EMULATOR_API_LEVEL};${TARGET};${ARCH}" \
#    "platforms;android-${EMULATOR_API_LEVEL}" \
#    "emulator"

#sdkmanager --install "system-images;android-30;google_apis;${EMU_ARCH}"
#sdkmanager --install "system-images;android-30;google_apis;x86_64"
#sdkmanager --install "system-images;android-30;google_apis;arm64-v8a"