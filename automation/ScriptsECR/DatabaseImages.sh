#!/bin/sh
ACCOUNT_ID="353681168015"
AWS_DEFAULT_REGION="us-east-1"
REPOSITORY_URI="$ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
IMAGE_REPO_NAME1="mongo"
IMAGE_REPO_NAME2="postgres"
IMAGE_REPO_NAME3="grafana"
IMAGE_REPO_NAME4=
IMAGE_REPO_NAME5=

#Login no docker com conta da aws#
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI

#Mongo#
docker pull mongo:latest 
docker tag mongo:latest $REPOSITORY_URI/$IMAGE_REPO_NAME1:mongo
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME1:mongo

#Postgres#
docker pull postgres:latest
docker tag postgres:latest $REPOSITORY_URI/$IMAGE_REPO_NAME2:postgres
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME2:postgres

#Grafana#
docker pull docker pull grafana/grafana:latest
docker tag grafana/grafana:latest $REPOSITORY_URI/$IMAGE_REPO_NAME2:grafana
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME3:grafana

#backend#
docker pull docker pull { }:latest
docker tag {}:latest $REPOSITORY_URI/$IMAGE_REPO_NAME4:{}
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME4:{}

#frontend#
docker pull docker pull {}:latest
docker tag {}:latest $REPOSITORY_URI/$IMAGE_REPO_NAME5:{}
docker push $REPOSITORY_URI/$IMAGE_REPO_NAME5:{}

