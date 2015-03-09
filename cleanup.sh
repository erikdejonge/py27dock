#!/bin/sh
yum remove -y kernel-debug-devel;
yum remove -y kernel-headers;
yum -y clean all;
rpm -qa --queryformat '%10{size} - %-25{name} \t %{version}\n' | sort -n > /installed.txt
yum -y remove gcc gcc-c++ cmake libyaml-devel gmp-devel binutils-devel boost-devel libmcrypt-devel libmemcached-devel jemalloc-devel libevent-devel sqlite-devel libxslt-devel libicu-devel tbb-devel libzip-devel mysql-devel bzip2-devel openldap-devel readline-devel elfutils-libelf-devel libcap-devel libyaml-devel libedit-devel lz4-devel libvpx-devel unixODBC-devel gmp-devel libpng-devel ImageMagick-devel expat-devel openssl-devel patch make libtool libidn-devel
rm -Rf /build
