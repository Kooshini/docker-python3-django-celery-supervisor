docker build -t {{YOUR_TAG}} .
docker tag {{YOUR_TAG}}:latest docker tag {{YOUR_TAG}}:latest {{REPO_URL}}
docker push docker push {{REPO_URL}}
aws aws elasticbeanstalk update-environment --environment-name {{ENV_NAME}} --version-label triple7events_app --profile {{YOUR_PROFILE}} --region {{REGION}}