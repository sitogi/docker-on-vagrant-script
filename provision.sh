#!/bin/sh

# Install Commands
yum -y install unzip git

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# Install Docker & docker-compose
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce
systemctl enable docker
systemctl start docker
curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > docker-compose
mv docker-compose /usr/local/bin/
chmod +x /usr/local/bin/docker-compose
gpasswd -a vagrant docker
systemctl restart docker

# workaround for https://github.com/tmatilai/vagrant-proxyconf/issues/206
mkdir -p /etc/systemd/system/docker.service.d
touch /etc/systemd/system/docker.service.d/http-proxy.conf

# install tmux 2.8 in CentOS 7
curl https://gist.githubusercontent.com/pokev25/4b9516d32f4021d945a140df09bf1fde/raw/d7b391ab715890ab8312c8b2c59798e3b0852645/install-tmux.sh > install-tmux.sh
chmod +x install-tmux.sh

# install vim 8
curl -L https://copr.fedorainfracloud.org/coprs/unixcommunity/vim/repo/epel-7/unixcommunity-vim-epel-7.repo -o /etc/yum.repos.d/unixcommunity-vim-epel-7.rep://copr.fedorainfracloud.org/coprs/unixcommunity/vim/repo/epel-7/unixcommunity-vim-epel-7.repo -o /etc/yum.repos.d/unixcommunity-vim-epel-7.repo
yum install vim

