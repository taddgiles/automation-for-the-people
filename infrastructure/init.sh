#!/bin/bash -e

echo "enter your GitHub user name. The user must own the fork!"
read GITHUB_USER_NAME

echo "enter a personal GitHub access token. Generate one here: https://github.com/settings/tokens (scopes needed: admin:repo_hook, repo)"
read GITHUB_OAUTH_TOKEN

aws cloudformation create-stack \\
  --region eu-west-1 \\
  --stack-name "aftp-pipeline"
  --template-body file://pipeline.yaml
  --capabilities CAPABILITY_IAM
  --parameters \\
    ParameterKey=GitHubUserName,ParameterValue=$GITHUB_USER_NAME \\
    ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN
