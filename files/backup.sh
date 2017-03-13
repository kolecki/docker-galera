#!/bin/bash
backup_time=$(date +%Y-%m-%d_%H%M)
mkdir /var/backup/$backup_time
innobackupex --user=root --no-timestamp /var/backup/$backup_time
innobackupex --user=root --apply-log /var/backup/$backup_time

tar cfz /var/backup/$backup_time.tgz /var/backup/$backup_time/

