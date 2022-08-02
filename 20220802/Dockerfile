FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim

ARG GOLANG_VERSION=1.18
ARG GOLANG_DOWNLOAD_SHA256=e85278e98f57cdb150fe8409e6e5df5343ecb13cebf03a5d5ff12bd55a80264f

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
    # 各種ツール
    go install golang.org/x/tools/cmd/goimports@latest && \
    go install mvdan.cc/gofumpt@latest && \
    go install github.com/daixiang0/gci@latest && \
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.47.3 && \
    go install github.com/Yamashou/gqlgenc@v0.0.7 && \
    go install github.com/gqlgo/nodecheck/cmd/nodecheck@latest && \
    go install mvdan.cc/sh/v3/cmd/shfmt@latest && \
    go install github.com/google/ko@latest && \
    go install github.com/sonatard/runenv@latest && \
    rm -rf ${GOPATH}/src ${GOPATH}/pkg && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev
