#!/usr/bin/env bash
set -euo pipefail

VERSION="0.0.1"
REPO="https://github.com/VirtuslabRnD/scala-cli/releases/download/v${VERSION}/scala-cli-x86_64-pc-linux.deb"

DEB_PACKAGE="scala-cli_${VERSION}.deb"
curl -fLo ./debian/${DEB_PACKAGE} $REPO

cd ./debian/

dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

apt-ftparchive release . > Release
echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" -abs -o - Release > Release.gpg
echo ${PGP_PASSPHRASE} | gpg --batch --yes --passphrase-fd 0 --default-key "${KEYNAME}" --clearsign -o - Release > InRelease


GIT_USERNAME="Github Actions"
GIT_EMAIL="actions@github.com"

MSG="Updates for $VERSION"

git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"


echo "Pushing changes"
#git checkout -b ci-update
#git commit -am "$MSG"
#git push origin ci-update --force-with-lease
