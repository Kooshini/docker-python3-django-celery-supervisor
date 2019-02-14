#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "Please supply the environment e.g. deploy.sh prod or deploy.sh staging"
    exit 1
fi
#config
DOCKER_LOGIN=`aws ecr get-login --no-include-email --region us-east-2 --profile triple7events`
DEPLOY_ENV=$1
#####
$DOCKER_LOGIN && docker build -t {{YOUR_TAG}} . && docker tag {{YOUR_TAG}}:latest {{REPO_URL}} && docker push {{REPO_URL}}
# update env
if [ $DEPLOY_ENV = "prod" ]
then
    echo "Deploying to the prod env"
    aws elasticbeanstalk update-environment --environment-name {{ENV_NAME}} --version-label triple7events_app --profile {{YOUR_PROFILE}} --region {{REGION}}
elif [ $DEPLOY_ENV = "staging" ]
then
    echo "Deploying to the staging env"
    aws elasticbeanstalk update-environment --environment-name {{ENV_NAME}} --version-label triple7events_app --profile {{YOUR_PROFILE}} --region {{REGION}}
else
    echo "Please supply a valid env"
    exit 1
fi
