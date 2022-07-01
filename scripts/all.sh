#!/bin/bash

set -eu
set -o pipefail

## 各種ディレクトリ読み込み
SCRIPTS_DIR="$(cd $(dirname "${0}") && pwd)/"     ## スクリプトの保存されているディレクトリパス

## ビルド時に必要なパッケージのインストール
cd "${SCRIPTS_DIR}/../src/onedrive/"
mk-build-deps --install --remove \
    --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' \
    debian/control
dh_auto_configure

## deb ファイルのビルド
bash "${SCRIPTS_DIR}/build.sh"
