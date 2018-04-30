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

# wait 20 seconds
sleepTime=30s
echo start! sleep $sleepTime
sleep $sleepTime
echo done! sleep $sleepTime

cd ..

# check clone
repo=git@bitbucket.org:imluckyman/balabala-builded.git
echo Start! git clone --depth=5 --branch $branchName $repo ./source
git clone --depth=5 --branch $branchName $repo ./source
echo Done! git clone --depth=5 --branch $branchName $repo ./source

# TODO now deploy all, in the future, will decided by trigger branch
travisBranch=$TRAVIS_BRANCH

echo will deploy according to travis branch $travisBranch

serverHost=`cat server_host`
remoteCheckPath=`DEPLOYING=true BRANCH=$travisBranch node ecosystem.config.js`

if [ "$travisBranch" = "master" -o "$travisBranch" = "release" ]
then
    if ssh $serverHost stat $remoteCheckPath \> /dev/null 2\>\&1
    then
        echo "File exists"
    else
        echo "File does not exist"
        pm2 deploy ecosystem.config.js production setup
    fi
    pm2 deploy ecosystem.config.js production
else
    if ssh $serverHost stat $remoteCheckPath \> /dev/null 2\>\&1
    then
        echo "File exists"
    else
        echo "File does not exist"
        pm2 deploy ecosystem.config.js development setup
    fi
    pm2 deploy ecosystem.config.js development
fi
