FROM golang:1.13-buster

##LABEL os=linux
##LABEL arch=armv7
##
##ENV CGO_ENABLED=1
##ENV CC=aarch64-linux-gnu-gcc
#
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
#
###Compile with different glibc
##RUN apk --no-cache add ca-certificates wget
##RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
##RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
##RUN apk add glibc-2.28-r0.apk
##RUN export CGO_LDFLAGS="-Xlinker -rpath=/path/to/another_glibc/lib"
#RUN apt-get update
#
#WORKDIR /cc_toolchain
#RUN git clone https://github.com/raspberrypi/tools
#ENV PATH "$PATH:/cc_toolchain/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian:/cc_toolchain/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin"
#
#RUN apt-get install -y build-essential make git-core ncurses-dev
#
##RUN apt-get install -y gcc-arm-linux-gnueabi lib32z1
##ENV CC=gcc-arm-linux-gnueabi
#ENV CGO_ENABLED=1
#ENV CC=aarch64-linux-gnu-gcc
#
#WORKDIR /gofastcom
#ADD go.mod .
#ADD go.sum .
#RUN go mod download
##ENTRYPOINT go build -mod=vendor -a -installsuffix cgo -o app .
#ENTRYPOINT ./scripts/build-all.sh




FROM golang:1.13-buster
LABEL os=linux
LABEL arch=armhf

#ENV GOOS=linux
#ENV GOARCH=arm64
#ENV CGO_ENABLED=1
#ENV CC=aarch64-linux-gnu-gcc
#ENV PATH="/go/bin/${GOOS}_${GOARCH}:${PATH}"
#ENV PKG_CONFIG_PATH=/usr/lib/aarch64-linux-gnu/pkgconfig
#
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

ENTRYPOINT go build -mod=vendor -a -installsuffix cgo -o builds/armhf.elf .
