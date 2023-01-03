#!/bin/sh
ACCOUNT_ID="353681168015"
AWS_DEFAULT_REGION="us-east-1"
REPOSITORY_URI="$ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
IMAGE_REPO_NAME="database"
docker pull mongo:latest
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI 
docker tag mongo:latest $REPOSITORY_URI/$IMAGE_REPO_NAME:mongo
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME:mongo
docker pull postgres:latest
docker tag postgres:latest $REPOSITORY_URI/$IMAGE_REPO_NAME:postgres
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME:postgres
