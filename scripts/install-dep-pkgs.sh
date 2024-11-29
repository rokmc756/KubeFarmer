
wget https://download.ceph.com/rpm-squid/el9/SRPMS/ceph-19.2.0-0.el9.src.rpm
wget https://download.ceph.com/rpm-squid/el9/SRPMS/ceph-release-1-1.el9.src.rpm


dnf install rpm-build \
CUnit-devel \
boost-random \
cryptsetup-devel \
daxctl-devel \
fmt-devel \
fuse-devel \
gperf \
gperftools-devel \
json-devel \
libaio-devel \
libarrow-devel \
libbabeltrace-devel \
libcap-devel \
libcap-ng-devel \
libibverbs-devel \
libicu-devel \
libnl3-devel \
liboath-devel \
libpmem-devel \
libpmemobj-devel \
librabbitmq-devel \
librdkafka-devel \
librdmacm-devel \
lmdb-devel \
lttng-ust-devel \
lua-devel \
lz4-devel \
nasm \
ndctl-devel \
ninja-build \
nss-devel \
parquet-libs-devel \
pkgconfig \
python3-Cython \
python3-sphinx \
qatlib-devel \
qatzip-devel \
re2-devel \
selinux-policy-devel \
snappy-devel \
sqlite-devel \
thrift-devel \
utf8proc-devel \
xfsprogs-devel \
xmlstarlet \
yaml-cpp-devel \
python3-Cython \
python3-sphinx \
qatlib-devel \
qatzip-devel \
selinux-policy-devel \
sqlite-devel \
xfsprogs-devel \
xmlstarlet \
yaml-cpp-devel

# (libudev) \

rpm -ivh ceph-19.2.0-0.el9.src.rpm
rpm -ivh ceph-release-1-1.el9.src.rpm

