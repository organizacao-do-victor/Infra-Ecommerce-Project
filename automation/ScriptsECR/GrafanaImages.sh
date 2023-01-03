#!/bin/sh
ACCOUNT_ID="353681168015"
AWS_DEFAULT_REGION="us-east-1"
REPOSITORY_URI="$ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
IMAGE_REPO_NAME="monitoring"
docker pull "imagens necessárias para monitoramento":latest
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI 
docker tag {}:latest $REPOSITORY_URI/$IMAGE_REPO_NAME:{}
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME:
