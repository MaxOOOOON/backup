#!/usr/bin/bash 

BACKUP_USER=root
BACKUP_HOST=10.0.0.30
BORG_PASSPHRASE='C7NNyjt5TZD3xztnxcb3kx'
REPO=$BACKUP_USER@$BACKUP_HOST:/var/backup/etc





ssh $BACKUP_USER@$BACKUP_HOST "mkdir -p /var/backup/etc"

export BORG_PASSPHRASE="$BORG_PASSPHRASE"
borg info $BACKUP_USER@$BACKUP_HOST:/var/backup/etc > /dev/null
backup_init=$?

if [ ${backup_init} -ne 0 ]
then 
borg init --encryption=repokey $BACKUP_USER@$BACKUP_HOST:/var/backup/etc
fi



borg create -v $REPO::'{hostname}-{now}'  /etc/
backup_exit=$?

borg prune -v $REPO --keep-within=3m --keep-monthly=12 --keep-yearly=1 


if [ ${backup_exit} -eq 0  ] 
then 
echo 'Backup complete succeeded'
else
echo 'Attention!!!!!!'
fi


# date +"%Y-%m-%d-%H-%M"
# export BORG_REPO='ssh://user@backup_server/mnt/backup/linode_01'
# export BORG_PASSPHRASE='set_your_passpharase'
# export BORG_RSH='ssh -i /home/kannan/.ssh/id_rsa_backups'