################
# intel settings
################

# sync time with gateway
# ----------------------
cat >> /etc/ntp.conf << EOF
server 172.16.0.1
EOF
ntpdate 172.16.0.1
# record configuration time
echo Start configuration at `date +%Y_%m_%d--%H:%M` >> /root/time.txt


# default hostname & gateway & dns-servers
# ----------------------------------------
echo devstoop > /etc/hostname
cat >> /etc/sysconfig/network << EOF
HOSTNAME=devstoop
DNS1=10.248.2.1
DNS2=10.248.2.5
DNS3=10.239.27.228
EOF


# adding proxies urls for each bash user
# --------------------------------------
echo '
export GIT_PROXY_COMMAND=/usr/bin/git-proxy
export proxyaddr=10.239.4.80
export proxyport=913
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
' >> /etc/bashrc

# adding alias
# ------------
cat >> /etc/bashrc << EOF
alias sls='screen -x'
EOF


# git's proxy confs
# -----------------

# script for git://
# ^^^^^^^^^^^^^^^^^
cat >> /usr/bin/git-proxy << EOF
#!/bin/sh
case $1 in
    *.intel.com|172.16.*|127.0.*|localhost|10.*)
        METHOD="-X connect"
    ;;
    *)
        METHOD="-X 5 -x proxy-shz.intel.com:1080"
    ;;
esac
/bin/nc.openbsd $METHOD $*
EOF
# make it executable
chmod +x /usr/bin/git-proxy

# let git know it
# ^^^^^^^^^^^^^^^
cat >> /etc/gitconfig << EOF
[core]
gitproxy=/usr/bin/git-proxy
EOF

# pip's conf
# ----------
cat >> /etc/pip.conf << EOF
[global]
default-timeout = 60
respect-virtualenv = true
build = /tmp/.pip/build
download-cache = /tmp/.pip/cache
index_url = http://pypi.python.org/simple/

[install]
use-mirrors = true
mirrors = http://pypi.python.org
EOF

# yum's confs
# -----------
cat >> /etc/yum.conf << EOF
proxy=http://proxy-shz.intel.com:913
EOF
# disable gpgcheck
sed -i s/gpgcheck=1/gpgcheck=0/g /etc/yum.conf

# wget's
# ------
sed -i s/.yoyodyne.com:18023/-shz.intel.com:913/g /etc/wgetrc

# hosts
# -----

echo "
" >> /etc/hosts

# add ssh keys
# ------------
mkdir -p /root/.ssh
cat >> /root/.ssh/authorized_keys << EOF 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQaaEBp/WD1Ma0AKPjieFwAKZC7FJDBzBl679WrJkYulKWGMO+RrKgmQZZimUygmaPdk0vbH4iCdDwU5OD0evmmsihom78Bqv+DYgp7SArOpXZJ3yLiPqSmkmoJ/W6CQP+ipeG+l3FxT5Xto2aICa53PRbI1nvS1lHKbYOoem2SgSZWY+qe/SV+g+FIDx7XPRKnnR8fBlxInCrTsCRE3KF06eyEhdR7EO3cF9+korS60ADbVHgdZuTFL/RsZ5y5iLX3Bg+VNGTnz/yOXs61BibBcNDg6szyT6biRc2fg+bvBj2e78oxzOd0RDZ8+pfNuVm7sCu1DquSunjY0JFfBY1 Generated-by-Wenjie
EOF
echo "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA0GmhAaf1g9TGtACj44nhcACmQuxSQwcwZeu/VqyZGLpSlhjD
vkayoJkGWYplMoJmj3ZNL2x+IgnQ8FOTg9Hr5prIoaJu/Aar/g2IKe0gKzqV2Sd8
i4j6kppJqCf1ugkD/oqXhvpdxcU+V7aNmiAmudz0WyNZ70tZRym2DqHptkoEmVmP
qnv0lfoPhSA8e1z0Sp50fHwZcSJwq07AkRNyhdOnshIXUexDt3BffpKK0utAA21R
4HWbkxS/0bGecuYi19wYPlTRk58/8jl7OtQYmwXDQ4OrM8k+m4kXNn4Pm7wY9nu/
KMczndEQ2fPqXzblZu7ArtQ6rkrp42NCRXwWNQIDAQABAoIBAQCvECtIgtc+d5q5
VNhVp1oQhNsj1/J5jy5eTpqYqb6oAMqifgbea/Bb6m5lBFVhChwwYcUQEugYm3pA
hVOiJNEtEdN5wkHLvab3blJ0NVUSOtHoaLy7UMJ6JtO8RmSoci5CwBPsM55VJAvs
DdIAJwWgljND4vwGf5pspmLhA6yXiyzPdgOQSfcxp8OpFAoFTOsUYxBQAJ+SIxGl
42X+tsi81O0UJS8ABV+uITlGEvfnLKmeMCK0Ww/hEMvPYJwV8w39aRVUSsJ1Wk2v
6a2taXmlUbARuJ8/voq3wrEshpaLga4mukSfnRAK29cZo65amMmRa7OaRpoBpcdc
2LXaxcm5AoGBAPD6qz23mB8ME2aans3kS3UZDhUtdjn2YvCgRXCYyxrL9ugLxQe+
GHYcXwwNiUnAe4719Tkw18K0c91y20eKjBgrHDXZKsPn28PdSDW5s+UvPRrjOuFu
OCCLjsJmWaItCtEFfIAzjth0s9rVmFquR3/GzALzw1rCtj6Ia1HQ58sbAoGBAN1n
SrSeKdLmKKtsXMqrYshbC0upKQzJ5LtLArWgEl1FX5cj7ssoB//sqtEuG47VfvNE
6U8VSG3T+eDCuWE6jgORI+jE3g3uS/w7+IvntzqdtBQIocWrIEoNkl1MgvHh3tsQ
9h2f/ZZEOdtuZl5gvWCcjI8bU5iccVAc+rxKX+jvAoGAT+mAge3xN1KE2ICr6vEr
CMDvR5yU2THYq50qieVRbSh4T4kfpKqoZ/qOlmuivF9lWgo8cOO+mSXISoZ9KyNJ
w/X/2+eRY/fui+xEtvRHMNhSdikmbH1lhX1iMRtJ3Br9vEUKfWUbmLJStl4gsOmc
ckYVf2EgxmdNkj0hAbe6NkMCgYEAlv/wgnjwe2b/y9JPAuaaq5z0eji3x4IWnupM
wcSXYceDp1gZb7MwqYonAh1ZLDRNreqM2KPiTw1oebM0raw62RHvFLzX2VZxumjI
Xdq+K5sNCzDL7D2G+xqAfWNGV2O+E1hhEtlgIVEMyKxl4u5FmpOKhbuUaxwfaA0r
sKlk+j8CgYEArIRe0I5WLM/DZAO3Ns2mW2nXklNsHQJ89wpxfLLdVX6LUd4NY/E2
1B7QZG72VJt6Ptpa30kM9HIDQaZdh+4r6uQWyAz2HSeeajxIA5cvTj2i51TvgtAr
HAeHsw7VvSDeDoJ+yTwQLiAv3mDGcYrCQpCZbI++7oMGYFj6Nd6RCDk=
-----END RSA PRIVATE KEY-----" > /root/.ssh/id_rsa
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQaaEBp/WD1Ma0AKPjieFwAKZC7FJDBzBl679WrJkYulKWGMO+RrKgmQZZimUygmaPdk0vbH4iCdDwU5OD0evmmsihom78Bqv+DYgp7SArOpXZJ3yLiPqSmkmoJ/W6CQP+ipeG+l3FxT5Xto2aICa53PRbI1nvS1lHKbYOoem2SgSZWY+qe/SV+g+FIDx7XPRKnnR8fBlxInCrTsCRE3KF06eyEhdR7EO3cF9+korS60ADbVHgdZuTFL/RsZ5y5iLX3Bg+VNGTnz/yOXs61BibBcNDg6szyT6biRc2fg+bvBj2e78oxzOd0RDZ8+pfNuVm7sCu1DquSunjY0JFfBY1 Generated-by-Wenjie" > /root/.ssh/id_rsa.pub

chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa.pub
chmod 644 /root/.ssh/authorized_keys
chown root.root /root -R


# screen configs
cat >> /etc/screenrc << EOF
caption always '%{=b cw}%-w%{=rb db}%>%n %t%{-}%+w%{-b}%< %{= kG}%-=%D %c%{-}'
shelltitle '$ |bash'
EOF
