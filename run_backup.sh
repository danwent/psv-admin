#!/bin/bash 

cd Perspectives-Server
python utilities/db2file.py notary.sqlite ../notary_backup/notary_dump.txt
cd ../notary_backup
git add notary_dump.txt
DATE=`date`
git commit -a -m "backup at: $DATE"
git push origin master

