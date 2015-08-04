#!/bin/bash

# This script will be dedicate for auto-gen anaconda files.

set -eEx

# Parameters
# ----------
ELEMENTS="centos7"
KS_NAME=test.cfg
AUTHOR=Wenjie
TOP_DIR=$(cd $(dirname "$0") && pwd)

# Initialize temp folders
# -----------------------
TMP=`mktemp -d`
PHASES="packages pre pre-install post traceback"
for PHASE in default $PHASES;do
    mkdir -p $TMP/${PHASE}.d
done
KS_FILE=$TMP/$KS_NAME


# Extract Elements
# ----------------
for ELEMENT in $ELEMENTS;do
    for PHASE in default $PHASES;do
        test -d $TOP_DIR/elements/$ELEMENT/${PHASE}.d/  && \
        cp $TOP_DIR/elements/$ELEMENT/${PHASE}.d/* $TMP/${PHASE}.d
    done
done

# Generate kickstart file
# -----------------------
echo "# Author: $AUTHOR
# Create At `date`
" > $KS_FILE
# command section
cat $TMP/default.d/* >> $KS_FILE
# add phases
for PHASE in $PHASES;do
    if [[ $(ls -l $TMP/${PHASE}.d/ | wc -l) -gt 1 ]];then
        echo '


        ' >> $KS_FILE
        echo '# ============' >> $KS_FILE
        echo "%$PHASE" >> $KS_FILE
        echo '# ============' >> $KS_FILE
        echo '

        ' >> $KS_FILE
        cat $TMP/${PHASE}.d/* >> $KS_FILE
        echo '%end' >> $KS_FILE
    fi
done
echo reboot >> $KS_FILE



# Output the results, and destory tmp
# -----------------------------------
cp $KS_FILE .
#rm -rf $TMP




