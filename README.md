# docker-cloudrun-go

[![Docker](https://github.com/builtbystack/docker-cloudrun-go/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/builtbystack/docker-cloudrun-go/actions/workflows/docker-publish.yml)

- GitHub Reposiitory
[builtbystack/docker-cloudrun-go](https://github.com/builtbystack/docker-cloudrun-go/)
- GitHub Container Registiry
[builtbystack/cloudrun-go](https://github.com/orgs/builtbystack/packages/container/package/cloudrun-go)

## Github Container Registry構築手順
1. [Docikerfile](Dockerfile)を用意する
2. [docker-publish.yml](.github/workflows/docker-publish.yml)を用意する
3. [organization -> Settings -> Packages](https://github.com/organizations/builtbystack/settings/packages) からContainer CreationのPublicにチェック
4. [Packages -> Settings ->  Options](https://github.com/orgs/builtbystack/packages/container/cloudrun-go/settings)からManage Actions accessからbuiltbystack/docker-cloudrun-goを追加してRoleをWriteに変更する、Repository sourceのInherit access from source repository (recommended)にチェックをいれてパッケージの管理権限をGithub Repositoryから引き継ぐ、
4. PushするとGithub ActionsからDocker imageのビルドとPushが実行される
5. CIを実行
6. [公開されたpackage](https://github.com/orgs/builtbystack/packages/container/package/cloudrun-go)のPackage SettingsからChange package visibilityをPublicにする

- 参考: https://docs.github.com/ja/packages/guides/migrating-to-github-container-registry-for-docker-images

## コンテナリビルド方法
- https://github.com/builtbystack/docker-cloudrun-go/actions から過去に成功したCIを選び再実行する
