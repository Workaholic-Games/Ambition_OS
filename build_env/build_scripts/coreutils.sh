. $DIST_ROOT/build_env/build_scripts/inc-start.sh $1 $(basename $0)

patch -Np1 -i ../coreutils-9.11-i18n-1.patch

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname

make
make DESTDIR=$LFS install

mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8



. $DIST_ROOT/build_env/build_scripts/inc-end.sh $1 $(basename $0)