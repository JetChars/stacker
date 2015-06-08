DEFAULT_DISK_SIZE=

. /opt/stack/devstack/openrc admin admin
glance image-create --name=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-${DEFAULT_DISK_SIZE} --store=file --disk-format=qcow2 --file=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib${DEFAULT_DISK_SIZE}.qcow2 --is-public=True --container-format=bare --min-disk=${DEFAULT_DISK_SIZE}
#nova flavor-create F${DEFAULT_DISK_SIZE} 11 81920 ${DEFAULT_DISK_SIZE} 40
#nova flavor-create F${DEFAULT_DISK_SIZE}h 12 40960 ${DEFAULT_DISK_SIZE} 20
#nova flavor-create F${DEFAULT_DISK_SIZE}q 13 20480 ${DEFAULT_DISK_SIZE} 10
nova boot --flavor=F${DEFAULT_DISK_SIZE}q --image=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-${DEFAULT_DISK_SIZE} test
