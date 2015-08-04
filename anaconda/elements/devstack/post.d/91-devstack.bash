# Install DevStack
# ================

# add user stack with devstack
# ----------------------------
groupadd stack
useradd -g stack -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
passwd stack --stdin << EOF
123456
EOF

# download devstack
# -----------------
wget ftp://172.16.0.1/devstack.2015_08_03.tar.gz --no-proxy
tar xvzf devstack.2015_08_03.tar.gz -C /
chown stack:stack /opt/stack/ -R
rm -f devstack.2015_08_03.tar.gz

