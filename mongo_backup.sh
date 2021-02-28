#!/bin/bash

Datetime="`date +%Y-%m-%d`"

datetime="`date +%Y-%m-%d-%H:%M:%S`"

backup_dir=/mongo_backup/daily_backup/

log_dir=/mongo_logs/

audit_log_dir=/mongo_Audit_logs/

mkdir -p /mongo_backup/daily_backup/$Datetime

#Mongodb backup for all the databases

mongodump --username <username> --password <password> --authenticationDatabase admin --out /mongo_backup/daily_backup/$Datetime --gzip

if [ $? = 0 ]; then

echo "$datetime MongoDB Backup was Success" >> /mongo_backup/daily_backup/mongo_backup.log

#Rotate the mongo error logs and audit logs

find $backup_dir -type d -mtime +7 -exec rm -rf {} +

find $log_dir -name '*.log.*' -mtime +30 -exec rm -rf {} +

find $audit_log_dir -name '*.log.*' -mtime +30 -exec rm -rf {} +

else

echo "$datetime MongoDB Backup was Failure" >> /mongo_backup/daily_backup/mongo_backup.log

fi



#End of the script

