#!/usr/bin/bash 

BACKUP_USER=root
BACKUP_HOST=10.0.0.30
BORG_PASSPHRASE='C7NNyjt5TZD3xztnxcb3kx'
REPO=$BACKUP_USER@$BACKUP_HOST:/var/backup/etc




if  ssh $BACKUP_USER@$BACKUP_HOST "ls /var/backup/etc"
then
ssh $BACKUP_USER@$BACKUP_HOST "mkdir /var/backup/etc"
else 
exit 0
fi

export BORG_PASSPHRASE="$BORG_PASSPHRASE"
borg init --encryption=repokey $BACKUP_USER@$BACKUP_HOST:/var/backup/etc


borg create -v --stats $REPO::'{hostname}-{now}'  /etc/
# backup_exit=$?

 borg prune -v --list $REPO --keep-daily=90 --keep-monthly=12 --keep-yearly=1 



# date +"%Y-%m-%d-%H-%M"
# export BORG_REPO='ssh://user@backup_server/mnt/backup/linode_01'
# export BORG_PASSPHRASE='set_your_passpharase'
# export BORG_RSH='ssh -i /home/kannan/.ssh/id_rsa_backups'