#!/usr/bin/env bash

echo "Start init..."
# how to encrypt sensitive files: https://docs.travis-ci.com/user/encrypting-files/

# import ssh keys
#openssl aes-256-cbc -K $encrypted_b231c297449e_key -iv $encrypted_b231c297449e_iv -in ./.travis/deploy_key.enc -out deploy_key -d
#openssl aes-256-cbc -K $encrypted_b231c297449e_key -iv $encrypted_b231c297449e_iv -in ./.travis/server_key.enc -out server_key -d

echo "Import ssh keys done"

# Start SSH agent
eval $(ssh-agent -s)

chmod 600 deploy_key
chmod 600 server_key

ssh-add deploy_key
ssh-add server_key

echo "Finish init."