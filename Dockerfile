#FROM golang:1.13rc1-alpine
#WORKDIR /gofastcom
#RUN apk update && apk add --no-cache gcc
#ADD go.mod .
#ADD go.sum .
#RUN go mod download
#RUN ls
#RUN ls -la
#ENTRYPOINT CGO_ENABLED=1 GOOS=linux go build -mod=vendor -a -installsuffix cgo -o app .


FROM golang:1.13-buster
LABEL os=linux
LABEL arch=amd64

ENV GOOS=linux
ENV GOARCH=amd64
ENV CGO_ENABLED=1
#ENV CC=aarch64-linux-gnu-gcc
#ENV PATH="/go/bin/${GOOS}_${GOARCH}:${PATH}"
#ENV PKG_CONFIG_PATH=/usr/lib/aarch64-linux-gnu/pkgconfig

## install build & runtime dependencies
#RUN dpkg --add-architecture arm64 \
#    && apt update \
#    && apt install -y --no-install-recommends \
#        protobuf-compiler \
#        upx \
#        gcc-aarch64-linux-gnu \
#        libc6-dev-arm64-cross \
#        pkg-config \
#        libsamplerate0:arm64 \
#        libsamplerate0-dev:arm64 \
#        libopusfile0:arm64 \
#        libopusfile-dev:arm64 \
#        libopus0:arm64 \
#        libopus-dev:arm64 \
#        libportaudio2:arm64 \
#        portaudio19-dev:arm64 \
#    && rm -rf /var/lib/apt/lists/*

## install build dependencies (code generators)
#RUN GOARCH=amd64 go get github.com/gogo/protobuf/protoc-gen-gofast \
#    && GOARCH=amd64 go get github.com/GeertJohan/go.rice/rice \
#    && GOARCH=amd64 go get github.com/micro/protoc-gen-micro

WORKDIR /gofastcom
ADD go.mod .
ADD go.sum .
RUN go mod download

ENTRYPOINT go build -mod=vendor -a -installsuffix cgo -o app .
