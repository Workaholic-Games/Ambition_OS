echo "Unmounting ${LFS:?}"
echo "Unbinding ${DIST_ROOT:?}"
sleep 1

umount $LFS/dist
echo "run"
umount $LFS/run
umount $LFS/sys
umount $LFS/proc
umount $LFS/dev/pts

umount $LFS/dev







