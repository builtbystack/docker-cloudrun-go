FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim

ARG GOLANG_VERSION=1.21.0
ARG GOLANG_DOWNLOAD_SHA256=d0398903a16ba2232b389fb31032ddf57cac34efda306a0eebac34f0965a0742

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
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.54.2 && \
    go install github.com/99designs/gqlgen@v0.17.40 && \
    go install github.com/Yamashou/gqlgenc@v0.16.0 && \
    go install github.com/gqlgo/nodecheck/cmd/nodecheck@v1.0.1 && \
    go install github.com/gqlgo/deprecatedquery/cmd/deprecatedquery@v0.0.3 && \
    go install github.com/gqlgo/optionalschema/cmd/optionalschema@v0.0.2 && \
    go install github.com/gqlgo/operationname/cmd/operationname@v0.0.1 && \
    go install github.com/gqlgo/iddirective/cmd/iddirective@v0.0.1 && \
    go install github.com/builtbystack/nopermission/cmd/nopermission@v0.0.2 && \
    go install github.com/daichirata/hammer@latest && \
    go install mvdan.cc/sh/v3/cmd/shfmt@latest && \
    go install github.com/google/yamlfmt/cmd/yamlfmt@latest && \
    go install github.com/google/ko@v0.12.0 && \
    go install github.com/sonatard/runenv@latest && \
    rm -rf ${GOPATH}/src ${GOPATH}/pkg && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev
