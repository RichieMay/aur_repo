#!/bin/env sh

version=`curl -sL "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/"|grep -Eo "([0-9]+\.)+[0-9]+"|sort -V|tail -n 1`
curl -o "microsoft-edge-stable_${version}-1_amd64.deb" "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_${version}-1_amd64.deb"

echo -e "the latest edge version is: ${version}\n"

sha256=`sha256sum "microsoft-edge-stable_${version}-1_amd64.deb"|awk '{print $1}'`
rm -f "microsoft-edge-stable_${version}-1_amd64.deb"

echo -e "update edge, sha256sum: ${sha256}\n"

cd microsoft-edge-stable
sed -i "/pkgver=/c\pkgver=${version}" PKGBUILD
sed -i "0,/'[0-9a-z]\{64\}'/s/'[0-9a-z]\{64\}'/'${sha256}'/g" PKGBUILD
makepkg --printsrcinfo > .SRCINFO

git commit -am "update edge version: ${version}"
git push
