#!/bin/bash

set -eu
set -o pipefail

### 設定関連 ####################################################################
## 各種ディレクトリ読み込み
SCRIPTS_DIR="$(cd $(dirname "${0}") && pwd)/"     ## スクリプトの保存されているディレクトリパス
ROOT_DIR="${SCRIPTS_DIR}/.."

## 各種設定
VERSION="2.4.19-1"


### ビルド ######################################################################
## ディレクトリ移動
cd "${ROOT_DIR}/src"

## 作業用ディレクトリの再作成
rm -rf tmp
mkdir -p tmp

## debian package のビルド
cp -r onedrive/ -t tmp/
cp -r debian -t tmp/onedrive/

## changelog の作成
cp ../scripts/changelog_template tmp/onedrive/debian/changelog
sed -i -r "s/%VERSION%/${VERSION}/g" tmp/onedrive/debian/changelog

cd tmp/onedrive/
fakeroot debian/rules clean -j"$(nproc)"
fakeroot debian/rules build -j"$(nproc)"
fakeroot debian/rules binary -j"$(nproc)"
