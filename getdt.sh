#!/bin/bash

set -e

CLI_OS="na"

if [ $# -eq 0 ]; then
  VERSION=latest
  echo "Downloading the latest version of devtool CLI..."
else
  VERSION=$1
  echo "Downloading version $1 of devtool CLI..."
fi

FILE_NAME="dt"
if $(echo "${OSTYPE}" | grep -q msys); then
  CLI_OS="win64"
  FILE_NAME="dt.exe"
elif $(echo "${OSTYPE}" | grep -q darwin); then
  arch_type=$(uname -m)
  if [ "${arch_type}" = "arm64" ]; then
    CLI_OS="macosx_arm64"
  else
    CLI_OS="macosx64"
  fi
else
  # Assume Linux x86
  CLI_OS="linux64"
  arch_type=$(uname -m)
  if [ "${arch_type}" = "aarch64" ]; then
    CLI_OS="linux_arm64"
  fi
fi
URL="https://gfx-assets.intel.com/artifactory/gfx-build-assets/build-tools/devtool-go/${VERSION}/artifacts/${CLI_OS}/${FILE_NAME}"

curl -XGET "$URL" -L -k -f > $FILE_NAME
chmod u+x $FILE_NAME

echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "Downloaded devtool to $PWD/$FILE_NAME"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo
