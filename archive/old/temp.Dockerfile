

# Install packages
RUN #apt-get -qqy update && \
#    apt-get -qqy --no-install-recommends install libc++1 \
#    curl ca-certificates && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download required packages
RUN #apt-get update -q \
#    && apt-get install --no-install-recommends --no-upgrade -q -y curl unzip git openssh-client jq