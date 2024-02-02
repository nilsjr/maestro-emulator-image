FROM nilsjrfn/android-sdk-base:latest
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

ARG API_LEVEL

# Install Android platform
RUN sdkmanager --install "platforms;android-$API_LEVEL"