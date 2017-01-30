#
# Usage:
#  docker run --rm -it \
#   -e STRATUM_URL=stratum+tcp://usa-1.liteguardian.com:3334 \
#   -e USERNAME=telamohn.1 \
#   -e PASSWORD=x \
#   telamon/armhf-cpuminer
#
FROM container4armhf/armhf-alpine

ENV BUILD_DEPS="automake autoconf curl-dev git make build-base"
ENV DEPS="libcurl"
RUN apk update && apk add $BUILD_DEPS $DEPS \
   && git clone --depth=1 https://github.com/pooler/cpuminer \
   && cd cpuminer/ \
   && ./autogen.sh \
   && ./configure CFLAGS="-O3" PREFIX=/usr/local \
   && make && make install \
   && cd / && rm -rf cpuminer/ \
   && apk del $BUILD_DEPS \
   && rm -rf /var/cache/apk/*

WORKDIR		/work
COPY entrypoint.sh /entrypoint
ENTRYPOINT ["/entrypoint"]

