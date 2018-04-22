#!/usr/bin/env bash

echo "Start post..."

# copy ecosystem.config.js to .build
cp ecosystem.config.js .build/

branchName=`cat branch`
echo branch name is $branchName

# push to built project
cd .build/
git add .
git commit -m "built code"
git checkout -b $branchName
# force push the files
git push origin $branchName -f

# TODO now deploy all, in the future, will decided by trigger branch
cd ..

pm2 deploy ecosystem.config.js development setup
pm2 deploy ecosystem.config.js development

pm2 deploy ecosystem.config.js production setup
pm2 deploy ecosystem.config.js production

