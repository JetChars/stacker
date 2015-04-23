sudo mkdir -p /home/hadoop/.ssh
sudo chmod 700 /home/hadoop/.ssh
sudo cat >> /home/hadoop/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9VSDVLkO0QAuS4AmRHgHrySnpCMD3/vf2boEKO7RDSoA0kuAeIijRuoxkO2HpoZ/RrUgJsohzumsmyDRfJC64HZo+mNRQ0WEfUg7hM4QOy+XrPafaghFmhfTcrSbCm65h6vzZ0OjIs8+h98Hjmb7NgrYsyO5LBh4NLVOXpD5VhbpC/AmgPXeUoAXQAI+8By3irfL8A9vGwBkV7bj044fDE7DFMOujA4uWfTxYrqZ/MGWs0KQtn5J5yMMhUZft/3LNxnhGbXIp6e4J8o+51TidABwXDUMg8w0G1wv1vQbbTJA9mrrGzK3T5h8fM0zEsdOkUKcv8VW5+GFdyBvpQee/ root@prime
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlBX6kzdnvlic6DgQTiQZun6Cow0x5KMM3LleRoUSGNqkNY1581cYxTTn/bwdLjChyR/BTCa9IdAD0oGZ18C6hwao2SvHTDi61ceHLwVcXxzc441fYUx1e913tljWKKaNayMppsYIx92BAmw1/YlxjghXoR3A1vqTyAAZGqOLKu/Bbqt4jb2FPHZ1V4IQyeLB5JO55+NyxCebQkRloFCA4E5BNG+rF562O4VjfAZkOec8vmOjWMZCxH5L+f6oOX/JgV7rYnSZGuvEPnvYZCENWVUTPb0ddm7i8hf3AWUIKgqk63X+L2sHrQovSF9F1LHNbtGenMQI6h7Ph5D7qGFRR root@wenjie
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQaaEBp/WD1Ma0AKPjieFwAKZC7FJDBzBl679WrJkYulKWGMO+RrKgmQZZimUygmaPdk0vbH4iCdDwU5OD0evmmsihom78Bqv+DYgp7SArOpXZJ3yLiPqSmkmoJ/W6CQP+ipeG+l3FxT5Xto2aICa53PRbI1nvS1lHKbYOoem2SgSZWY+qe/SV+g+FIDx7XPRKnnR8fBlxInCrTsCRE3KF06eyEhdR7EO3cF9+korS60ADbVHgdZuTFL/RsZ5y5iLX3Bg+VNGTnz/yOXs61BibBcNDg6szyT6biRc2fg+bvBj2e78oxzOd0RDZ8+pfNuVm7sCu1DquSunjY0JFfBY1 Generated-by-Nova
EOF

sudo chmod 644 /home/hadoop/.ssh/authorized_keys
sudo chown hadoop.hadoop /home/hadoop -R


sudo rm -rf /etc/security/limits.d
sudo cat >> /etc/security/limits.conf << EOF
*                -       nproc           100000
*                -       nofile          100000
*                -       memlock         unlimited
EOF

echo "hadoop ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
sudo passwd hadoop --stdin << EOF
123456
EOF

echo "nameserver 10.248.2.1" > /etc/resolv.conf



sudo chown hadoop:hadoop /mnt -R

cat >> /etc/yum.conf << EOF
proxy=http://child-prc.intel.com:913
EOF

yum install -y openssh-clients
