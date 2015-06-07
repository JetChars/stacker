#!/usr/bin/env bash

# Sample ``local.sh`` for user-configurable tasks to run automatically
# at the successful conclusion of ``stack.sh``.

# NOTE: Copy this file to the root DevStack directory for it to work properly.

# This is a collection of some of the things we have found to be useful to run
# after ``stack.sh`` to tweak the OpenStack configuration that DevStack produces.
# These should be considered as samples and are unsupported DevStack code.


# Keep track of the DevStack directory
TOP_DIR=$(cd $(dirname "$0") && pwd)

# Import common functions
source $TOP_DIR/functions

# Use openrc + stackrc + localrc for settings
source $TOP_DIR/stackrc

# Destination path for installation ``DEST``
DEST=${DEST:-/opt/stack}

if is_service_enabled nova; then

    # Import ssh keys
    # ---------------

    # Import keys from the current user into the default OpenStack user (usually
    # ``demo``)

    # Get OpenStack user auth
    source $TOP_DIR/openrc

    # Add first keypair found in localhost:$HOME/.ssh
    for i in $HOME/.ssh/id_rsa.pub $HOME/.ssh/id_dsa.pub; do
        if [[ -r $i ]]; then
            nova keypair-add --pub_key=$i `hostname`
            break
        fi
    done
    nova keypair-add --pub_key=/opt/stack/stacker/nova/wenjie.pub wenjie

    # Get OpenStack admin auth
    source $TOP_DIR/openrc admin admin

    # Name of new flavor
    # set in ``local.conf`` with ``DEFAULT_INSTANCE_TYPE=m1.micro``
    MI_NAME=m1.micro

    # Create micro flavor if not present
    if [[ -z $(nova flavor-list | grep $MI_NAME) ]]; then
        nova flavor-create $MI_NAME 6 128 0 1
    fi
    nova flavor-create F500 11 81920 500 40
    nova flavor-create F500h 12 40960 500 20
    nova flavor-create F500q 13 20480 500 10
 
    # Add tcp/22 and icmp to default security group
    nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
    nova secgroup-add-rule default tcp 1 65535 0.0.0.0/0
    nova secgroup-add-rule default udp 1 65535 0.0.0.0/0

    echo 'dnsmasq_config_file = /etc/neutron/dnsmasq-neutron.conf' >> /etc/neutron/dhcp_agent.ini
    echo 'dhcp-option-force=26,1400' >> /etc/neutron/dnsmasq-neutron.conf
    sudo pkill -1 neutron-dhcp-agent

    # Get OpenStack demo auth
    source $TOP_DIR/openrc demo demo
    
    nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
    nova secgroup-add-rule default tcp 1 65535 0.0.0.0/0
    nova secgroup-add-rule default udp 1 65535 0.0.0.0/0

    glance image-create --name=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-500 --store=file --disk-format=qcow2 --file=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-500G.qcow2 --is-public=True --container-format=bare --min-disk=500
    nova boot --flavor=F500q --image=centos_sahara_vanilla_hadoop_2_6_latest.selinux-permissive.fixlib-500 test
fi
