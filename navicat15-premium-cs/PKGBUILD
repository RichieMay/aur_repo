# Maintainer: RichieMay

pkgname=navicat15-premium-cs
pkgver=15.0.21
pkgrel=1
pkgdesc="Navicat Premium is a multi-connection database development tool. (Chinese Simplified)"
arch=(x86_64)
options=(!strip)
url='https://rlds.tk/index_zh.html'
license=('GPL3')
source=(
    # The download url always download latest version
    "navicat15-premium-cs-${pkgver}.AppImage::https://pan.rainss.cc/navicat/${pkgver}/Navicat_Premium_15_cs-x86_64.appimage"
    'navicat15.desktop'
)
sha256sums=(
    '65b97d85b024b343864e0bd535dda6198d872df0d6253a646e9d05160a1a6d6b'
    '6477d39b5c6247a6e5769fb65ac99504ba602170794f5610a1e301cd0832032e'
)

prepare() {
    chmod +x "navicat15-premium-cs-${pkgver}.AppImage"
    ./"navicat15-premium-cs-${pkgver}.AppImage" --appimage-extract
    chmod -R 0755 squashfs-root
    mv squashfs-root/* ./
    rm -rf squashfs-root
}

package() {
    _root_na_dir=opt/$pkgname
    _na_dir=$pkgdir/$_root_na_dir
    install -d $_na_dir

    cd $srcdir
    cp -r usr $_na_dir
    install AppRun $_na_dir
    cp manual.pdf $_na_dir
    cp cacert.pem $_na_dir

    install -d $pkgdir/usr/share/applications
    cp $srcdir/navicat15.desktop $pkgdir/usr/share/applications

    _icon_dir=usr/share/icons/hicolor/256x256/apps
    install -d $pkgdir/$_icon_dir
    ln -s /$_root_na_dir/$_icon_dir/navicat-icon.png $pkgdir/$_icon_dir/navicat15.png
}
