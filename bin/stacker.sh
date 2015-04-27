#!/bin/bash

DOOPSHOT_XTRACE=$(set +o | grep xtrace)
RC_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}") && pwd)/..
pwd
echo $RC_DIR
#TOP_DIR=$(cd $(dirname "$0") && pwd)
exit 0
# Import functions & configurations

source $TOP_DIR/lib/config_ini
source $TOP_DIR/lib/config_xml
source $TOP_DIR/lib/hadoop
source $TOP_DIR/lib/functions

# Get options
# ===========
while getopts c: option
do
    case "$option" in
        c)
            DOOPSHOT_CONF_FILE=$OPTARG;;
        \?)
            hint_stacker
            exit 1;;
    esac
done

#[[ -z $LOG_FILE ]] && echo 'log file required!' && hint && exit 1

DOOPSHOT_CONF_FILE=${DOOPSHOT_CONF_FILE:-$TOP_DIR/conf/config.ini}
meta_get_section $DOOPSHOT_CONF_FILE doopshot doopshotrc | sed -e /^$/d -e /^#/d > $TOP_DIR/.doopshotrc.auto
meta_get_section $DOOPSHOT_CONF_FILE hadoop hadooprc | sed -e /^$/d -e /^#/d > $TOP_DIR/.hadooprc.auto
cat $DOOPSHOT_CONF_FILE | sed -ne /^slave/p | sed s/slaves/SLAVES/g >> $TOP_DIR/.doopshotrc.auto
echo "DOOPSHOT_CONF_FILE=$DOOPSHOT_CONF_FILE" >> $TOP_DIR/.doopshotrc.auto

source $TOP_DIR/.doopshotrc.auto

# Print the commands being run so that we can see the command that triggers an error. 
set -o xtrace

# Check Before Running Jobs
# =========================

if [ `screen -ls | grep $SCREEN_NAME | awk -F" " '{print $1}'` != "" ]; then
    echo "screen $SCREEN_NAME exists!"
    exit 1
fi

ntpdate $NTP_SERVER &>/dev/null

# Make sure dstat, screen and ntpdate available
# =============================================

for HOST in $HOSTS;do
    for PKG in dstat ntpdate; do
        ssh_check_install $HOST $PKG
    done
done


# Prepare Logging dir
# ===================

LOG_NAME=${TASK}_${RUNNER}_`echo $(date "+%Y%m%d%H%M")`_${THEME}
#timestamp=`echo $(date "+%s")`
LOG_PATH="$LOG_HOME/$LOG_NAME"
mkdir -p $LOG_PATH
cp $LOG_FILE $LOG_PATH
cp $TOP_DIR/.doopshotrc.auto $LOG_PATH/doopshotrc
cp $TOP_DIR/.hadooprc.auto $LOG_PATH/hadooprc


# Config and Sync Hadoop Settings
# ===============================

RM=`iniget $TOP_DIR/.hadooprc.auto yarn-site yarn.resourcemanager.hostname`
NN_DIRS=`iniget $TOP_DIR/.hadooprc.auto hdfs-site dfs.namenode.name.dir | sed -e s/,/\ /g -e s#file\:\/\/##g`
DN_DIRS=`iniget $TOP_DIR/.hadooprc.auto hdfs-site dfs.datanode.data.dir | sed -e s/,/\ /g -e s#file\:\/\/##g`


echo "HADOOP_HOME=$HADOOP_HOME"
if [ ${HADOOP_HOME} == "" ];then
    HADOOP_HOME=$HADOOP_COMMON_HOME  
fi

hadoop_restart

if [ "${TASK}" == "no" ];then
    echo "No test will run."
    exit 0
fi

exit 0


# Create a screen & adding tabs
# =============================

echo "*** start now~ ***" 

NL=`echo -ne '\015'`
dstat_start_screen

# Run job tag
screen -S $SCREEN_NAME -X screen -t hadoop
screen -S $SCREEN_NAME -p hadoop -X stuff "bash $TOP_DIR/bin/hibenchrun.sh $TASK $LOG_NAME $NL"

# Restore xtrace
$DOOPSHOT_XTRACE


# Reminding log dir
# =================

echo ""
echo ""
echo ""
echo "LOG FILES in $LOGPATH"

