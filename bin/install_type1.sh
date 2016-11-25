#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

#apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" update

#sudo apt-get install build-essential libtool autoconf automake scons python-setuptools lsof git texlive check
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install build-essential libtool autoconf automake scons python-setuptools lsof git texlive check

#apt-get install libcairo2-dev libffi-dev pkg-config python-dev python-pip fontconfig apache2 libapache2-mod-wsgi git-core collectd memcached gcc g++ make libtool automake
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install libcairo2-dev libffi-dev pkg-config python-dev python-pip fontconfig apache2 libapache2-mod-wsgi git-core collectd memcached gcc g++ make libtool automake

cd /usr/local/src
git clone https://github.com/armon/statsite.git
cd statsite; ./autogen.sh; ./bootstrap.sh; ./configure; make
cp statsite /usr/local/sbin/; cp sinks/graphite.py /usr/local/sbin/statsite-sink-graphite.py

cd /usr/local/src
VERSION=2.4.1
wget -O synthesize-${VERSION}.tar.gz https://github.com/obfuscurity/synthesize/archive/v${VERSION}.tar.gz
tar zxf synthesize-${VERSION}.tar.gz
rm synthesize-${VERSION}.tar.gz
cd synthesize-${VERSION}

sed -i 's|^git clone https://github.com/armon/statsite.git|#git clone https://github.com/armon/statsite.git|' install
sed -i 's|^cd ../statsite;|#cd ../statsite;|' install
sudo ./install
cd /usr/local/src

#apt-get install haproxy
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install haproxy

cat <<'_EOF_'>>/opt/graphite/conf/carbon.conf
[relay]
USER = carbon
LOG_LISTENER_CONNECTIONS = False
RELAY_METHOD = consistent-hashing
REPLICATION_FACTOR = 1
MAX_DATAPOINTS_PER_MESSAGE = 500
MAX_QUEUE_SIZE = 10000
USE_FLOW_CONTROL = True
DESTINATIONS = 127.0.0.1:20104:1, 127.0.0.1:20204:2, 127.0.0.1:20304:3,
               127.0.0.1:20404:4, 127.0.0.1:20504:5, 127.0.0.1:20604:6,
               127.0.0.1:20704:7, 127.0.0.1:20804:8, 127.0.0.1:20904:9,
               127.0.0.1:21004:10, 127.0.0.1:21104:11, 127.0.0.1:21204:12,
               127.0.0.1:21304:13, 127.0.0.1:21404:14, 127.0.0.1:21504:15,
               127.0.0.1:21604:16

[relay:1]
LINE_RECEIVER_PORT = 2113
PICKLE_RECEIVER_PORT = 2114

[relay:2]
LINE_RECEIVER_PORT = 2213
PICKLE_RECEIVER_PORT = 2214

[relay:3]
LINE_RECEIVER_PORT = 2313
PICKLE_RECEIVER_PORT = 2314

[relay:4]
LINE_RECEIVER_PORT = 2413
PICKLE_RECEIVER_PORT = 2414

[relay:5]
LINE_RECEIVER_PORT = 2513
PICKLE_RECEIVER_PORT = 2514

[relay:6]
LINE_RECEIVER_PORT = 2613
PICKLE_RECEIVER_PORT = 2614

[relay:7]
LINE_RECEIVER_PORT = 2713
PICKLE_RECEIVER_PORT = 2714

[relay:8]
LINE_RECEIVER_PORT = 2813
PICKLE_RECEIVER_PORT = 2814

[cache]
USER = carbon
CACHE_WRITE_STRATEGY = sorted
MAX_CACHE_SIZE = 4000000
USE_FLOW_CONTROL = True
WHISPER_FALLOCATE_CREATE = True
MAX_CREATES_PER_MINUTE = 12000
MAX_UPDATES_PER_SECOND = 20000
USE_INSECURE_UNPICKLER = False
LOG_CACHE_HITS = False
LOG_CACHE_QUEUE_SORTS = False
LOG_LISTENER_CONNECTIONS = False
LOG_UPDATES = False
ENABLE_LOGROTATION = False
WHISPER_AUTOFLUSH = False

[cache:1]
LINE_RECEIVER_PORT = 20103
PICKLE_RECEIVER_PORT = 20104
CACHE_QUERY_PORT = 7012

[cache:2]
LINE_RECEIVER_PORT = 20203
PICKLE_RECEIVER_PORT = 20204
CACHE_QUERY_PORT = 7022

[cache:3]
LINE_RECEIVER_PORT = 20303
PICKLE_RECEIVER_PORT = 20304
CACHE_QUERY_PORT = 7032

[cache:4]
LINE_RECEIVER_PORT = 20403
PICKLE_RECEIVER_PORT = 20404
CACHE_QUERY_PORT = 7042

[cache:5]
LINE_RECEIVER_PORT = 20503
PICKLE_RECEIVER_PORT = 20504
CACHE_QUERY_PORT = 7052

[cache:6]
LINE_RECEIVER_PORT = 20603
PICKLE_RECEIVER_PORT = 20604
CACHE_QUERY_PORT = 7062

[cache:7]
LINE_RECEIVER_PORT = 20703
PICKLE_RECEIVER_PORT = 20704
CACHE_QUERY_PORT = 7072

[cache:8]
LINE_RECEIVER_PORT = 20803
PICKLE_RECEIVER_PORT = 20804
CACHE_QUERY_PORT = 7082

[cache:9]
LINE_RECEIVER_PORT = 20903
PICKLE_RECEIVER_PORT = 20904
CACHE_QUERY_PORT = 7092

[cache:10]
LINE_RECEIVER_PORT = 21003
PICKLE_RECEIVER_PORT = 21004
CACHE_QUERY_PORT = 7102

[cache:11]
LINE_RECEIVER_PORT = 21103
PICKLE_RECEIVER_PORT = 21104
CACHE_QUERY_PORT = 7112

[cache:12]
LINE_RECEIVER_PORT = 21203
PICKLE_RECEIVER_PORT = 21204
CACHE_QUERY_PORT = 7122

[cache:13]
LINE_RECEIVER_PORT = 21303
PICKLE_RECEIVER_PORT = 21304
CACHE_QUERY_PORT = 7132

[cache:14]
LINE_RECEIVER_PORT = 21403
PICKLE_RECEIVER_PORT = 21404
CACHE_QUERY_PORT = 7142

[cache:15]
LINE_RECEIVER_PORT = 21503
PICKLE_RECEIVER_PORT = 21504
CACHE_QUERY_PORT = 7152

[cache:16]
LINE_RECEIVER_PORT = 21603
PICKLE_RECEIVER_PORT = 21604
CACHE_QUERY_PORT = 7162
_EOF_


cat <<'_EOF_'>/opt/graphite/conf/storage-schemas.conf
[collectd]
pattern = ^collectd\.
retentions = 10s:1w, 60s:1y

[haggar]
pattern = ^haggar\.
retentions = 10s:1d, 60s:1w, 1d:1y

[default]
pattern = .*
retentions = 60s:1y
_EOF_


cat <<'_EOF_'>/etc/haproxy/haproxy.cfg
global
    #log /dev/log    local0
    #log /dev/log    local1 notice
    log 127.0.0.1 local0 notice
    chroot /var/lib/haproxy
    user haproxy
    group haproxy
    daemon
    maxconn 8192
    pidfile /var/run/haproxy.pid

defaults
    balance roundrobin
    log global
    mode    tcp
    retries 3
    option  redispatch
    contimeout 5000
    clitimeout 50000
    srvtimeout 50000

# plaintext listener
listen carbon_relay_2003 0.0.0.0:2003
    server carbon_relay_2113 127.0.0.1:2113 check maxconn 1024
    server carbon_relay_2213 127.0.0.1:2213 check maxconn 1024
    server carbon_relay_2313 127.0.0.1:2313 check maxconn 1024
    server carbon_relay_2413 127.0.0.1:2413 check maxconn 1024
    server carbon_relay_2513 127.0.0.1:2513 check maxconn 1024
    server carbon_relay_2613 127.0.0.1:2613 check maxconn 1024
    server carbon_relay_2713 127.0.0.1:2713 check maxconn 1024
    server carbon_relay_2813 127.0.0.1:2813 check maxconn 1024

# pickle listener
listen carbon_relay_2004 0.0.0.0:2004
    server carbon_relay_2114 127.0.0.1:2114 check maxconn 1024
    server carbon_relay_2214 127.0.0.1:2214 check maxconn 1024
    server carbon_relay_2314 127.0.0.1:2314 check maxconn 1024
    server carbon_relay_2414 127.0.0.1:2414 check maxconn 1024
    server carbon_relay_2514 127.0.0.1:2514 check maxconn 1024
    server carbon_relay_2614 127.0.0.1:2614 check maxconn 1024
    server carbon_relay_2714 127.0.0.1:2714 check maxconn 1024
    server carbon_relay_2814 127.0.0.1:2814 check maxconn 1024
_EOF_    

'
git config --global user.name "root at type1"
git config --global user.email root@localhost.localdomain
git install etckeeper
cd /etc 
'


# for type3
'
sudo pvcreate /dev/nvme0n1
sudo pvcreate /dev/nvme1n1
sudo vgcreate graphite_vol /dev/nvme0n1 /dev/nvme1n1
sudo lvcreate -i 2 -I 4 -l 100%VG -n graphite_vg graphite_vol
sudo mkfs.ext4 /dev/graphite_vol/graphite_vg
sudo service carbon-cache stop
sudo service apache2 stop
sudo mkdir /opt2
sudo mv /opt/graphite /opt2/
sudo mount /dev/graphite_vol/graphite_vg /opt/
sudo mv /opt2/graphite /opt/
sudo service carbon-cache start
sudo service apache2 start
'

sed -i 's/^ENABLED=0/ENABLED=1/' /etc/default/haproxy

cat <<'_EOF_'>>/etc/rsyslog.conf
$ModLoad imudp
$UDPServerAddress 127.0.0.1
$UDPServerRun 514
_EOF_

cat <<'_EOF_'>/etc/rsyslog.d/haproxy.conf
if ($programname == 'haproxy') then -/var/log/haproxy.log
_EOF_

service rsyslog restart


service memcached restart
service apache2 restart
service statsite restart

cp /opt/graphite/examples/init.d/carbon-relay /etc/init.d/
chmod 755 /etc/init.d/carbon-relay

sed -i 's/^INSTANCES=1/INSTANCES=16/' /etc/init.d/carbon-cache

service carbon-cache stop
sleep 4
service carbon-cache start
/etc/init.d/carbon-relay start
service collectd restart
service haproxy restart

