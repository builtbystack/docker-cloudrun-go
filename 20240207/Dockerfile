FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim

ARG GOLANG_VERSION=1.22.0
ARG GOLANG_DOWNLOAD_SHA256=f6c8a87aa03b92c4b0bf3d558e28ea03006eb29db78917daec5cfb6ec1046265

ARG GOPATH=/go
ENV GOPATH=${GOPATH} \
	PATH=/go/bin:/usr/local/go/bin:$PATH

RUN set -eux && \
    # 基本ツール
	apt-get update && \
	apt-get install -yqq --no-install-suggests --no-install-recommends \
		libc6-dev \
		make \
		unzip \
		npm \
		dnsutils && \
	rm -rf /var/lib/apt/lists/* && \
	\
    # Go
	curl -o go.tgz -sSL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" && \
	echo "${GOLANG_DOWNLOAD_SHA256} *go.tgz" | sha256sum -c - && \
	tar -C /usr/local -xzf go.tgz && \
	rm go.tgz && \
	mkdir ${GOPATH} && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev
