FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim

ARG GOLANG_VERSION=1.18rc1
ARG GOLANG_DOWNLOAD_SHA256=9ea4e6adee711e06fa95546e1a9629b63de3aaae85fac9dc752fb533f3e5be23

ARG GOLANGCI_LINT_VERSION=v1.43.0

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
    go install github.com/Yamashou/gqlgenc@v0.0.5 && \
    go install github.com/gqlgo/nodecheck/cmd/nodecheck@latest && \
    go install mvdan.cc/sh/v3/cmd/shfmt@latest && \
    go install github.com/google/ko@latest && \
    go install github.com/sonatard/runenv@latest && \
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin $GOLANGCI_LINT_VERSION && \
    rm -rf ${GOPATH}/src ${GOPATH}/pkg && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev
