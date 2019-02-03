FROM alpine:3.9 AS build
COPY checksum /checksum
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.tar.gz
RUN sha256sum -c /checksum
RUN tar -xzf hugo_0.54.0_Linux-64bit.tar.gz
RUN mv hugo /usr/local/bin

FROM alpine:3.9 AS deploy
COPY --from=build /usr/local/bin/hugo /usr/local/bin/hugo
RUN apk add --no-cache git bash openssh-client
CMD /bin/bash