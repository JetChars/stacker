#!/usr/bin/env bash

# Sample ``local.sh`` for user-configurable tasks to run automatically
# at the successful conclusion of ``stack.sh``.

# NOTE: Copy this file to the root ``devstack`` directory for it to
# work properly.

# This is a collection of some of the things we have found to be useful to run
# after ``stack.sh`` to tweak the OpenStack configuration that DevStack produces.
# These should be considered as samples and are unsupported DevStack code.

umask 022
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
FILES=/opt/stack/devstack/files
DEST=${DEST:-/opt/stack}
TOP_DIR=$(cd $(dirname "$0") && pwd)
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5

source $TOP_DIR/functions
source $TOP_DIR/lib/config
source $TOP_DIR/stackrc
source $TOP_DIR/lib/database
source $TOP_DIR/lib/rpc_backend
source $TOP_DIR/lib/apache
source $TOP_DIR/lib/tls
source $TOP_DIR/lib/infra
source $TOP_DIR/lib/oslo
source $TOP_DIR/lib/stackforge
source $TOP_DIR/lib/horizon
source $TOP_DIR/lib/keystone
source $TOP_DIR/lib/glance
source $TOP_DIR/lib/nova
source $TOP_DIR/lib/cinder
source $TOP_DIR/lib/swift
source $TOP_DIR/lib/ceilometer
source $TOP_DIR/lib/heat
source $TOP_DIR/lib/neutron
source $TOP_DIR/lib/ldap
source $TOP_DIR/lib/dstat
source $TOP_DIR/openrc admin admin

cleanup_swift
install_swift
configure_swift
create_swift_disk

#swift-init --run-dir=${SWIFT_DATA_DIR}/run all restart || true
sudo /etc/init.d/rsync restart
#echo ${SWIFT_DATA_DIR} $SWIFT_DIR ${SWIFT_CONF_DIR}
#local type
#for type in object container account; do
    #swift-init --run-dir=${SWIFT_DATA_DIR}/run ${type} stop || true
    #run_process s-${type} "$SWIFT_DIR/bin/swift-${type}-server ${SWIFT_CONF_DIR}/${type}-server/1.conf -v"
#done
sudo swift-init all start
