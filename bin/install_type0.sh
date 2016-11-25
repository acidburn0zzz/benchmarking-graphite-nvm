#!/bin/bash

apt-get update
apt-get install -y git

wget https://grafanarel.s3.amazonaws.com/builds/grafana_3.1.1-1470047149_amd64.deb
apt-get install -y adduser libfontconfig
dpkg -i grafana_3.1.1-1470047149_amd64.deb
service grafana-server start


curl -O https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
sudo tar -xvf go1.6.linux-amd64.tar.gz
sudo mv go /usr/local
mkdir $HOME/work
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/work/bin" > ~/.profile
echo "export GOPATH=$HOME/work" >> ~/.profile
source ~/.profile
go get github.com/gorsuch/haggar


  
  