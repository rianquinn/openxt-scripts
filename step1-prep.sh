#!/bin/bash

set -e

TMP_DIR="$(mktemp -d)"
CERTS_DIR="${HOME}/openxt/certs"

mkdir -p "${CERTS_DIR}"

pushd "${TMP_DIR}"

# set bash as default shell
echo "dash dash/sh boolean false" | sudo debconf-set-selections
sudo dpkg-reconfigure -p critical dash

if [ "$(readlink /bin/sh)" != "bash" ]; then
  echo "wrong shell!"
  exit 1
fi

sudo apt-get -y install guilt iasl quilt bin86 bcc libncurses5-dev libsdl1.2-dev liburi-perl genisoimage policycoreutils binutils gcc make unzip
sudo apt-get -y install g++ texi2html subversion gawk chrpath texinfo automake

wget http://ftp.us.debian.org/debian/pool/main/g/gmp/libgmpxx4ldbl_4.3.2+dfsg-1_i386.deb
wget http://ftp.us.debian.org/debian/pool/main/g/gmp/libgmp3c2_4.3.2+dfsg-1_i386.deb
wget http://ftp.us.debian.org/debian/pool/main/g/gmp/libgmp3-dev_4.3.2+dfsg-1_i386.deb

sudo dpkg -i libgmpxx4ldbl_4.3.2+dfsg-1_i386.deb libgmp3c2_4.3.2+dfsg-1_i386.deb libgmp3-dev_4.3.2+dfsg-1_i386.deb

wget http://www.haskell.org/ghc/dist/6.12.3/ghc-6.12.3-i386-unknown-linux-n.tar.bz2
tar jxf ghc-6.12.3-i386-unknown-linux-n.tar.bz2
pushd ghc-6.12.3
./configure --prefix=/usr
sudo make install
popd

# generate certs
pushd  "${CERTS_DIR}"
openssl genrsa -out prod-cakey.pem 2048
openssl genrsa -out dev-cakey.pem 2048
openssl req -new -x509 -key prod-cakey.pem -out prod-cacert.pem -days 1095
openssl req -new -x509 -key dev-cakey.pem -out dev-cacert.pem -days 1095
popd

popd #TMP_DIR
