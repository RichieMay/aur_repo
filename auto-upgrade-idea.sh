#!/bin/env sh
json=`curl -sL "https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build=" | jq '.IIU[0]'`

version=`echo $json | jq -r '.version'`
idea_jbr_sha256_url=`echo $json | jq -r '.downloads.linux.checksumLink'`
idea_no_jbr_sha256_url=`echo $json | jq -r '.downloads.linuxWithoutJBR.checksumLink'`

idea_jbr_sha256=`curl -sL $idea_jbr_sha256_url | awk '{print $1}'`
idea_no_jbr_sha256=`curl -sL $idea_no_jbr_sha256_url | awk '{print $1}'`

if [ ${#idea_jbr_sha256} -ne 64 -o ${#idea_no_jbr_sha256} -ne 64 ]; then
    echo "get sha256 error!!!"
fi

echo -e "the latest idea version is: ${version}\n"

echo -e "update intellij-idea-ultimate-with-jbr, sha256sum: ${idea_jbr_sha256}\n"
cd intellij-idea-ultimate-with-jbr
sed -i "/pkgver=/c\pkgver=${version}" PKGBUILD
sed -i "0,/'[0-9a-z]\{64\}'/s/'[0-9a-z]\{64\}'/'${idea_jbr_sha256}'/g" PKGBUILD
makepkg --printsrcinfo > .SRCINFO

git commit -m "update to ${version}"
git push

echo -e "update intellij-idea-ultimate-no-jbr, sha256sum: ${idea_no_jbr_sha256}\n"
cd ../intellij-idea-ultimate-without-jbr
sed -i "/pkgver=/c\pkgver=${version}" PKGBUILD
sed -i "0,/'[0-9a-z]\{64\}'/s/'[0-9a-z]\{64\}'/'${idea_no_jbr_sha256}'/g" PKGBUILD
makepkg --printsrcinfo > .SRCINFO

git commit -m "update to ${version}"
git push
