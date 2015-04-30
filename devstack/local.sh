. /opt/stack/devstack/openrc admin admin
glance image-create --name=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-500 --store=file --disk-format=qcow2 --file=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-500G.qcow2 --is-public=True --container-format=bare --min-disk=500
nova flavor-create F500 11 81920 500 40
nova flavor-create F500h 12 40960 500 20
nova flavor-create F500q 13 20480 500 10
nova boot --flavor=F500q --image=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-500 test
