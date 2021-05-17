#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM golang:1.16.4-buster

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
        autoconf \
        automake \
        libtool \
        curl \
        unzip \
	cmake

RUN cd /var/lib/apt/lists/ && git clone https://github.com/google/protobuf.git \
&& cd protobuf && git submodule update --init --recursive && ./autogen.sh \
&& ./configure --prefix=/usr/local/ && make && make install && ldconfig

RUN cd /usr/local/ && git clone -b v1.37.0 https://github.com/grpc/grpc \
&& cd grpc && git submodule update --init && mkdir -p cmake/build \
&& cd cmake/build && cmake ../.. && make protoc grpc_php_plugin

#RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go 
#RUN go install google.golang.org/protobuf/cmd/protoc-gen-go
#RUN go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
#RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc

RUN rm -rf /var/lib/apt/lists/*
