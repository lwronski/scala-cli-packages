#!/usr/bin/env sh

VERSION="0.0.1"
REPO="https://github.com/VirtuslabRnD/scala-cli/releases/download/v${VERSION}/scala-cli-x86_64-pc-linux.deb"

DEB_PACKAGE="scala-cli_${VERSION}.deb"
curl -fLo ./debian/${DEB_PACKAGE} $REPO

cd ./debian/

dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" -abs -o - Release > Release.gpg
echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" --clearsign -o - Release > InRelease