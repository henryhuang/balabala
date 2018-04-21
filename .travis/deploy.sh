#!/usr/bin/env bash

echo "Start post..."

# copy ecosystem.config.js to .build
cp ecosystem.config.js ./build/

branchName=cat branch
# push to built project
cd .build/
git init
git checkout -b $branchName
git remote add origin git@bitbucket.org:imluckyman/balabala-builded.git
# force push the files
git push origin $branchName -f

# TODO now deploy all, in the future, will decided by trigger branch
cd ..
pm2 deploy ecosystem.config.js development
pm2 deploy ecosystem.config.js production

