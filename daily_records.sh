#!/bin/bash

# shoud be managed by crontab

source ".env"



# print time
date >> $LOG_FILE

# activate environment
{
    set -e
    source $PATH_TO_ACTIVATE

    # run command
    cd $PATH_TO_MANAGE
    python3 manage.py get_daily_records
} || {
    echo "Error Happen" >> $LOG_FILE
}


# end log seperator
echo "-----------------------------------" >> $LOG_FILE
