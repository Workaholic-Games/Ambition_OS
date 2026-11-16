export LC_ALL=POSIX
export LFS_TGT=x86_64-lfs-linux-gnu
export PATH=$LFS/tools/bin:/bin:/usr/bin:/sbin:/usr/sbin

echo
echo "Glibc"
echo
sleep 1

cd $LFS/sources
tar -xf glibc-2.44.tar.xz
cd glibc-2.44


ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3

patch -Np1 -i ../glibc-fhs-1.patch
patch -Np1 -i ../glibc-2.44-upstream_fixes-1.patch

mkdir -v build
cd       build

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib           \
      --enable-kernel=5.10

make
make DESTDIR=$LFS install

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

echo
echo "TESTING GLIBC"
echo
echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
$LFS_TGT-readelf -l a.out | grep ': /lib'

grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log || true
grep -B3 "^ $LFS/usr/include" dummy.log || true
grep 'SEARCH.*/usr/lib' dummy.log | sed 's|; |\n|g' || true
grep "/lib.*/libc.so.6 " dummy.log || true
grep found dummy.log || true
rm -v a.out dummy.log

echo "removing"
cd $LFS/sources
rm -rf glibc-2.44