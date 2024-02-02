FROM nilsjrfn/android-sdk-base:latest
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

# Install Android platform
ENV API_LEVEL=30

RUN sdkmanager --install "platforms;android-${API_LEVEL}"