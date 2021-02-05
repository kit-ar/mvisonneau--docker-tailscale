FROM alpine:3.13

ARG ARCH=amd64
ARG VERSION=1.4.2

RUN \
  apk add --no-cache iptables iproute2 ca-certificates bash \
  && apk add --no-cache --virtual=.install-deps curl tar \
  && curl -sL "https://pkgs.tailscale.com/stable/tailscale_${VERSION}_${ARCH}.tgz" \
     | tar -zxf - -C /usr/local/bin --strip=1 tailscale_${VERSION}_${ARCH}/tailscaled tailscale_${VERSION}_${ARCH}/tailscale \
  && apk del .install-deps

COPY entrypoint /usr/local/bin/entrypoint

ENTRYPOINT ["/usr/local/bin/entrypoint"]