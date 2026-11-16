set -e

echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

if ! test $(whoami) == "distbuild" ; then
    echo "Must run as distbuild!"
    exit -1
fi

echo "Creating build environment..."
echo $DIST_ROOT
cd $DIST_ROOT/build_env

#bash -e build_scripts/binutils-pass-1.sh
#bash -e build_scripts/gcc-pass-1.sh
#bash -e build_scripts/linux-headers.sh
#bash -e build_scripts/glibc.sh
#bash -e build_scripts/libstdcpp-pass-1.sh gcc-16.2.0.tar.xz
#bash -e build_scripts/m4.sh m4-1.4.21.tar.xz
#bash -e build_scripts/ncurses.sh ncurses-6.6.tar.gz
#bash -e build_scripts/bash.sh bash-5.3.tar.gz
#bash -e build_scripts/coreutils.sh coreutils-9.11.tar.xz
#bash -e build_scripts/diffutils.sh diffutils-3.12.tar.xz
#bash -e build_scripts/file.sh file-5.48.tar.gz
#bash -e build_scripts/findutils.sh findutils-4.11.0.tar.xz
#bash -e build_scripts/gawk.sh gawk-5.4.1.tar.xz
#bash -e build_scripts/grep.sh grep-3.12.tar.xz
#bash -e build_scripts/gzip.sh gzip-1.14.tar.xz
#bash -e build_scripts/make.sh make-4.4.1.tar.gz
#bash -e build_scripts/patch.sh patch-2.8.tar.xz
#bash -e build_scripts/sed.sh sed-4.10.tar.xz
#bash -e build_scripts/tar.sh tar-1.35.tar.xz
#bash -e build_scripts/xz.sh xz-5.8.3.tar.xz
#bash -e build_scripts/binutils-pass-2.sh binutils-2.47.tar.xz
#bash -e build_scripts/gcc-pass-2.sh gcc-16.2.0.tar.xz

sudo --preserve-env=PATH,DIST_ROOT,LFS build_scripts/build-chroot.sh

echo "Done"