#!/usr/bin/env bash

echo "Start init..."
# how to encrypt sensitive files: https://docs.travis-ci.com/user/encrypting-files/

echo "====1"
cat ~/.ssh/config
echo "====1"

# import ssh keys
openssl aes-256-cbc -K $encrypted_9ece5568f913_key -iv $encrypted_9ece5568f913_iv -in ./.travis/assets.zip.enc -out assets.zip -d

unzip assets.zip

# Start SSH agent
#eval $(ssh-agent -s)

chmod 600 deploy_key
chmod 600 server_key

cp deploy_key ~/.ssh/
cp server_key ~/.ssh/

cat config >> ~/.ssh/config

echo "====2"
cat ~/.ssh/config
echo "====2"

#ssh-add deploy_key
#ssh-add server_key

echo "Import ssh keys done"
echo "Finish init."