# Change lines below marked CHANGEME to correspond to your project
# ----------------------------------------------------------------
#     Build: docker build -t <image-name> .
#       Run: docker run -e USER_REPO=github-user/github-project --publish 81:9000 <image-name>
# Daemonize: docker run -e github-user/github-project -d --publish 81:9000 <image-name>
#
FROM node:lts-alpine3.12

# Install/update git
RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

# We deploy into /srv - you can change this if you're careful.
# See container-startup.sh if you do decide to make changes
RUN mkdir -p /srv
WORKDIR /srv

COPY container-startup.sh /tmp
RUN chmod 700 /tmp/container-startup.sh

# Note: We typically prefer 9000 for any open API service port
#       for consistency
EXPOSE 9000

# Start up the container
ENTRYPOINT ["/bin/bash", "/srv/container-startup.sh"]
