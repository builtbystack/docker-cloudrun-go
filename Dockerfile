FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim

ARG GOLANG_VERSION=1.16.7
ARG GOLANG_DOWNLOAD_SHA256=7fe7a73f55ba3e2285da36f8b085e5c0159e9564ef5f63ee0ed6b818ade8ef04

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
    cd $(mktemp -d); go mod init tmp; go get golang.org/x/tools/cmd/goimports; cd - && \
    cd $(mktemp -d); go mod init tmp; go get mvdan.cc/gofumpt/gofumports@v0.1.1; cd - && \
    cd $(mktemp -d); go mod init tmp; go get mvdan.cc/sh/v3/cmd/shfmt; cd - && \
    go get -u github.com/sachaos/xerrchk/cmd/xerrchk && \
    go install github.com/gqlgo/nodecheck/cmd/nodecheck@latest && \
    go install github.com/google/ko@latest && \
    go install github.com/sonatard/runenv@latest && \
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin $GOLANGCI_LINT_VERSION && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev && \
    \
    rm -rf ${GOPATH}/src ${GOPATH}/pkg && \
    # ここで入れるのは、modulesのcacheを消してしまうと、参照したいテンプレートファイルがなくなってしまって正しく動作しないため、cache消去後に入れている
    cd $(mktemp -d); go mod init tmp; go get -u github.com/Yamashou/gqlgenc@v0.0.2-gql; cd -
