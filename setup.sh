#!/bin/bash 

if [ $# != 2 ] 
then 
	echo "usage: <seed-db-dump> <backup-repo-name>" 
	exit 1
fi 

mkdir logs

# setup DB file and notary keys 
cd Perspectives-Server
python utilities/create_tables.py notary.sqlite
bash utilities/create_key_pair.sh notary.priv notary.pub
grep "Start Host\|End Host" $1 > no_keys.txt
python utilities/file2b2.py no_keys.txt notary.sqlite
cd ..

# setup crontab
crontab psv-admin-scripts/crontab_content

# setup backup 
if ! [ -f ~/.ssh/id_rsa ]
then 
	echo "Generating new SSH key"
	ssh-keygen -t rsa
fi 
 
echo "SSH public key:" 
cat ~/.ssh/id_rsa.pub

mkdir notary_backup
cd notary_backup 
git init
git remote add origin gitosis@www.networknotary.org:$2.git
git config user.name "$2"
git config user.email "<none>"
git pull origin master # in case this is a rebuild
