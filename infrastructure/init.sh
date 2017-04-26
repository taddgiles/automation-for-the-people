#!/bin/bash -e

echo "Enter a GitHub access token for the KualiCoSaaSOps account. (scopes needed: admin:repo_hook, repo)"
read GITHUB_OAUTH_TOKEN

echo "Enter the name of the GitHub repo to deploy"
read $GITHUB_REPO

aws cloudformation create-stack \
  --region us-west-2 \
  --stack-name $GITHUB_REPO-us-west-2-cp \
  --template-body file://pipeline.yaml \
  --capabilities CAPABILITY_IAM \
  --parameters \
    ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN
    ParameterKey=GitHubRepo,ParameterValue=$GITHUB_REPO
