ARG osversion=xenial
FROM ubuntu:${osversion}

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE

RUN echo "VCS_REF: "${VCS_REF}", BUILD_DATE: "${BUILD_DATE}", VERSION: "${VERSION}

LABEL maintainer="frank.foerster@ime.fraunhofer.de" \
      description="Dockerfile providing the StringTie software" \
      version=${VERSION} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url="https://github.com/greatfireball/ime_stringtie.git"

WORKDIR /opt

RUN apt update && apt install --yes --no-install-recommends \
        build-essential \
	ca-certificates \
	wget \
	zlib1g-dev && \
    wget -O stringtie.tar.gz https://github.com/gpertea/stringtie/archive/v1.3.4d.tar.gz && \
    tar xzf stringtie.tar.gz && \
    rm stringtie.tar.gz && \
    ln -s stringtie* stringtie && \
    cd  stringtie && \
    make release && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/stringtie/:$PATH

VOLUME /data

WORKDIR /data
