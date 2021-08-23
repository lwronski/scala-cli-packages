#!/usr/bin/env bash
set -euo pipefail

VERSION="0.0.1"
REPO="https://github.com/VirtuslabRnD/scala-cli/releases/download/v${VERSION}/scala-cli-x86_64-pc-linux.rpm"

DEB_PACKAGE="scala-cli_${VERSION}.rpm"
curl -fLo ./CentOS/Packages/${DEB_PACKAGE} $REPO

cd ./CentOS/

# https://unix.stackexchange.com/questions/328601/rpmsign-with-cli-password-prompt
#gpg-preset-passphrase --passphrase ${PGP_PASSPHRASE} --preset ${KEYNAME}
# rpmsign --define "_gpg_name <email" --addsign Packages/*.rpm
#rpmsign --addsign Packages/*.rpm

apt-get install -y createrepo
createrepo /CentOS/Packages