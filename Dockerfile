FROM liupeng0518/jdk:1.5.6.1
RUN apk update \
  && apk add docker-cli \
  && rm -rf /var/cache/apk/*
