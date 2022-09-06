FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim

ARG GOLANG_VERSION=1.19
ARG GOLANG_DOWNLOAD_SHA256=464b6b66591f6cf055bc5df90a9750bf5fbc9d038722bb84a9d56a2bea974be6

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
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.49.0 && \
    go install github.com/Yamashou/gqlgenc@v0.0.9 && \
    go install github.com/gqlgo/nodecheck/cmd/nodecheck@latest && \
    go install github.com/gqlgo/deprecatedquery/cmd/deprecatedquery@latest && \
    go install github.com/gqlgo/optionalschema/cmd/optionalschema@latest && \
    go install mvdan.cc/sh/v3/cmd/shfmt@latest && \
    go install github.com/google/ko@v0.12.0 && \
    go install github.com/sonatard/runenv@latest && \
    rm -rf ${GOPATH}/src ${GOPATH}/pkg && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev
