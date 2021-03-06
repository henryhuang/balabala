#!/usr/bin/env bash

echo "Start init..."
echo branch is $TRAVIS_BRANCH
# how to encrypt sensitive files: https://docs.travis-ci.com/user/encrypting-files/

# import ssh keys
openssl aes-256-cbc -K $encrypted_038f56157259_key -iv $encrypted_038f56157259_iv -in .travis/assets.zip.enc -out assets.zip -d

unzip assets.zip

# Start SSH agent
#eval $(ssh-agent -s)

chmod 600 deploy_key
chmod 600 server_key

cp deploy_key ~/.ssh/
cp server_key ~/.ssh/

# get server host
serverHost=`cat server_host`
# replace all server_host placeholder in config file
sed -i 's/${server_host}/'$serverHost'/g' config
# append to ~/.ssh/config file
cat config >> ~/.ssh/config

ssh-keyscan $serverHost >> ~/.ssh/known_hosts

#ssh-add deploy_key
#ssh-add server_key

echo "Import ssh keys done"
echo "Finish init."