# Install Hadoop
# ==============

# add user hadoop with hadoop-2.6.0
# ---------------------------------
groupadd hadoop
useradd -g hadoop -s /bin/bash -d /opt/hadoop -m hadoop
echo "hadoop ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
passwd hadoop --stdin << EOF
123456
EOF

# download hadoop-2.6.0
# ---------------------
wget ftp://172.16.0.1/hadoop-2.6.0.tar.gz --no-proxy
tar xvzf hadoop-2.6.0.tar.gz -C /opt/hadoop/
chown hadoop:hadoop /opt/hadoop/ -R
rm -f hadoop-2.6.0.tar.gz

# fix x64 lib issue for hadoop
# ----------------------------
wget ftp://172.16.0.1/hadoop-native-64-2.6.0.tar --no-proxy
tar xvf hadoop-native-64-2.6.0.tar -C /opt/hadoop-2.6.0/lib/native/
rm -f hadoop-native-64-2.6.0.tar
