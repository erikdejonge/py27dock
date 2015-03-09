FROM    centos
RUN     yum install -y epel-release && yum clean all
RUN     yum -y update && yum clean all
RUN     yum -y install supervisor cronie yum-cron && yum clean all
ADD     supervisord.conf /etc/supervisord.conf
ADD     crond.ini /etc/supervisord.d/crond.ini
RUN     chmod 600 /etc/supervisord.conf /etc/supervisord.d/*.ini
RUN     mkdir -p /var/lock/subsys
RUN     touch /var/lock/subsys/yum-cron
RUN     sed -i 's/apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
RUN     sed -i 's/apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron-hourly.conf
ADD     bashrc.sh /
RUN     cat /bashrc.sh >> /root/.bashrc
RUN     rm /bashrc.sh
CMD     ["/usr/bin/supervisord"]
ADD     get-pip.py /
RUN     mkdir /build
ADD     gmp-6.0.0a.tar.bz2 /build
RUN     yum -y update
RUN     yum -y install epel-release
RUN     yum install -y gcc-c++
RUN     yum install -y git
RUN     yum install -y make
RUN     yum install -y net-tools
RUN     yum install -y wget
RUN     yum install -y vim
RUN     yum install -y procps
RUN     yum install -y mlocate
RUN     yum install -y links
RUN     yum install -y zlib-devel.x86_64
RUN     yum install -y python-devel
RUN     yum install -y libffi-devel
RUN     python /get-pip.py; rm -f /get-pip.*
RUN     yum upgrade -y
RUN     yum install -y pyOpenSSL.x86_64
RUN     pip install multiprocessing
RUN     pip install gevent
RUN     pip install redis
RUN     pip install msgpack-python
RUN     pip install ujson
RUN     pip install inflection
RUN     pip install python-cjson
RUN     pip install celery
RUN     pip install bcrypt;
RUN     pip install Pygments
RUN     pip install cython git+git://github.com/surfly/gevent.git#egg=gevent
WORKDIR /build/gmp-6.0.0
RUN     yum install -y m4
RUN     ./configure
RUN     make install;
RUN     pip install pycrypto;
RUN     yum install -y tar;
RUN     yum install -y pigz;
RUN     easy_install -U distribute
RUN     pip install -r /requirements.txt
RUN     rm -Rf /build;
RUN     yum -y clean all;
RUN     echo nameserver 8.8.8.8 > /etc/resolv.conf
RUN     updatedb;
ADD     Dockerfile /
ADD     cleanup.sh /
RUN     cleanup.sh
WORKDIR /
