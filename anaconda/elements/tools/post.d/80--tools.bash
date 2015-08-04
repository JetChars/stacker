
# add third party repos & tools
# =============================

# add repo rpmforge & epel
# ------------------------
yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
yum install -y http://mirrors.ustc.edu.cn/fedora/epel/epel-release-latest-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY*
#yum clean all
#yum makecache
#yum update -y

# install other tools
yum install -y dstat agedu iperf

# script for changing hostname 
# ----------------------------
echo '#!/bin/bash 
hostname $1
echo $1 > /etc/hostname
#echo "127.0.0.1 $1" >> /etc/hosts 
sed -i s/HOSTNAME=.*/HOSTNAME=$1/g /etc/sysconfig/network 
' > /root/changehost.sh
chmod +x /root/changehost.sh

# script for adding proxies temporary
# -----------------------------------
echo '
#!/bin/bash

# Use script like this
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# source /intel-pxy.sh proxy-ir.intel.com
# source /intel-pxy.sh proxy-ir.intel.com 912
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

proxyaddr=$1
proxyport=$2
export GIT_PROXY_COMMAND=/usr/bin/git-proxy
export proxyaddr=${proxyaddr:-proxy-shz.intel.com}
export proxyport=${proxyport:-913}
export http_proxy="http://$proxyaddr:$proxyport"
export https_proxy="https://$proxyaddr:$proxyport"
export ftp_proxy="ftp://$proxyaddr:$proxyport"
export socks_proxy="socks://$proxyaddr:$proxyport"
export no_proxy="localhost,*intel.com:913,172.16.0.0/16,10.0.0.0/8,127.0.0.0/8"
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export FTP_PROXY=$ftp_proxy
export SOCKS_PROXY=$socks_proxy
export NO_PROXY=$no_proxy
' > /intel-pxy.sh
chmod +x /intel-pxy.sh

