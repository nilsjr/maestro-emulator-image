FROM nilsjrfn/android-sdk-30:latest
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

# Install system images
ENV ARCH=x86 \
    TARGET=google_apis \
    EMULATOR_API_LEVEL=30

# API 30 system image
RUN sdkmanager --install "system-images;android-${EMULATOR_API_LEVEL};${TARGET};${ARCH}" \
    "platforms;android-${EMULATOR_API_LEVEL}" \
    "emulator"