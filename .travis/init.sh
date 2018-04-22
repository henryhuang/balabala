#!/usr/bin/env bash

echo "Start init..."
# how to encrypt sensitive files: https://docs.travis-ci.com/user/encrypting-files/

echo "====1"
cat ~/.ssh/config
echo "====2"

# import ssh keys
openssl aes-256-cbc -K $encrypted_038f56157259_key -iv $encrypted_038f56157259_iv -in ./.travis/keys.zip.enc -out keys.zip -d

unzip keys.zip

# Start SSH agent
eval $(ssh-agent -s)

chmod 600 deploy_key
chmod 600 server_key

ssh-add deploy_key
ssh-add server_key

echo "Import ssh keys done"
echo "Finish init."