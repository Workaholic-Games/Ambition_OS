. $DIST_ROOT/build_env/build_scripts/inc-start.sh $1 $(basename $0)

export LFS_TGT=x86_64-lfs-linux-gnu
export PATH=$LFS/tools/bin:/bin:/usr/bin:/sbin:/usr/sbin

echo "SED function"
sed '6031s/$add_dir//' -i ltmain.sh

echo "mkdr"
rm -rf build
mkdir -v build
cd       build

echo "../config"
../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --enable-gprofng=no        \
    --disable-werror           \
    --enable-64-bit-bfd        \
    --enable-new-dtags         \
    --enable-default-hash-style=gnu

echo "make"
make
make DESTDIR=$LFS install

echo "rm"
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

. $DIST_ROOT/build_env/build_scripts/inc-end.sh $1 $(basename $0)