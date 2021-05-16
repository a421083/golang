#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM buildpack-deps:buster-scm

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
	&& rm -rf /var/lib/apt/lists/*

RUN cd /var/lib/apt/lists/ && git clone https://github.com/google/protobuf.git \
&& cd cd protobuf && git submodule update --init --recursive && ./autogen.sh \
&& ./configure --prefix=/usr/local/ && make && make install && ldconfig