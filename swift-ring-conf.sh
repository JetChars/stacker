#!/bin/bash

rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz
$SLAVES="SLAVES"
for i in object container account; do
    swift-ring-builder ${i}.builder create 10 3 1
done

for j in SLAVES;do
    swift-ring-builder object.builder add r1z1-${j}:6013/sdb1 100
done

for j in SLAVES;do
    swift-ring-builder account.builder add r1z1-${j}:6012/sdb1 100
done

for j in SLAVES;do
    swift-ring-builder container.builder add r1z1-${j}:6011/sdb1 100
done

for i in object container account; do
    swift-ring-builder ${i}.builder rebalance
done

for j in SLAVES;do
    scp *.gz stack@$j:/ect/swift
done

sudo swift-init all restart
