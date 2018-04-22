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

# wait 10 seconds
sleep 10s

cd ..

# TODO now deploy all, in the future, will decided by trigger branch
travisBranch=$TRAVIS_BRANCH

echo will deploy according to travis branch $travisBranch

if [$travisBranch == "master" || $travisBranch == "release"]
then
    pm2 deploy ecosystem.config.js production setup
    pm2 deploy ecosystem.config.js production
else
    pm2 deploy ecosystem.config.js development setup
    pm2 deploy ecosystem.config.js development
fi
