echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled

sudo mkdir -p /home/hadoop/.ssh
sudo chmod 700 /home/hadoop/.ssh
sudo cat >> /home/hadoop/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9VSDVLkO0QAuS4AmRHgHrySnpCMD3/vf2boEKO7RDSoA0kuAeIijRuoxkO2HpoZ/RrUgJsohzumsmyDRfJC64HZo+mNRQ0WEfUg7hM4QOy+XrPafaghFmhfTcrSbCm65h6vzZ0OjIs8+h98Hjmb7NgrYsyO5LBh4NLVOXpD5VhbpC/AmgPXeUoAXQAI+8By3irfL8A9vGwBkV7bj044fDE7DFMOujA4uWfTxYrqZ/MGWs0KQtn5J5yMMhUZft/3LNxnhGbXIp6e4J8o+51TidABwXDUMg8w0G1wv1vQbbTJA9mrrGzK3T5h8fM0zEsdOkUKcv8VW5+GFdyBvpQee/ root@prime
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlBX6kzdnvlic6DgQTiQZun6Cow0x5KMM3LleRoUSGNqkNY1581cYxTTn/bwdLjChyR/BTCa9IdAD0oGZ18C6hwao2SvHTDi61ceHLwVcXxzc441fYUx1e913tljWKKaNayMppsYIx92BAmw1/YlxjghXoR3A1vqTyAAZGqOLKu/Bbqt4jb2FPHZ1V4IQyeLB5JO55+NyxCebQkRloFCA4E5BNG+rF562O4VjfAZkOec8vmOjWMZCxH5L+f6oOX/JgV7rYnSZGuvEPnvYZCENWVUTPb0ddm7i8hf3AWUIKgqk63X+L2sHrQovSF9F1LHNbtGenMQI6h7Ph5D7qGFRR root@wenjie
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQaaEBp/WD1Ma0AKPjieFwAKZC7FJDBzBl679WrJkYulKWGMO+RrKgmQZZimUygmaPdk0vbH4iCdDwU5OD0evmmsihom78Bqv+DYgp7SArOpXZJ3yLiPqSmkmoJ/W6CQP+ipeG+l3FxT5Xto2aICa53PRbI1nvS1lHKbYOoem2SgSZWY+qe/SV+g+FIDx7XPRKnnR8fBlxInCrTsCRE3KF06eyEhdR7EO3cF9+korS60ADbVHgdZuTFL/RsZ5y5iLX3Bg+VNGTnz/yOXs61BibBcNDg6szyT6biRc2fg+bvBj2e78oxzOd0RDZ8+pfNuVm7sCu1DquSunjY0JFfBY1 Generated-by-Nova
EOF

sudo cat >> /home/hadoop/.ssh/id_rsa << EOF
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
EOF

sudo chmod 644 /home/hadoop/.ssh/authorized_keys
sudo chmod 600 /home/hadoop/.ssh/id_rsa
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

cat >> /etc/hosts << EOF
10.1.1.51 test-1
10.1.1.52 test-2
10.1.1.53 test-3
10.1.1.54 test-4
10.1.1.55 test-5
10.1.1.56 test-6
10.1.1.57 test-7
10.1.1.58 test-8
10.1.1.59 test-9
10.1.1.60 test-10
10.1.1.61 test-11
10.1.1.62 test-12
10.1.1.63 test-13
10.1.1.64 test-14
10.1.1.65 test-15
10.1.1.66 test-16
EOF

sudo ip route del default; sudo ip route add default via 10.1.1.2
