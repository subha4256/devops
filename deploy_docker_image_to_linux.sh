#!/bin/bash
# Define variables
GITHUB_REPO="https://github.com/subha4256/php-push-ec2-ssh-docker-2024.git"
CONTAINER_NAME="myphp74"
IMAGE_NAME="azuresubha/php7.4_13_4_2022:latest"
LOCAL_CODE_DIR="/home/ubuntu/gitrepo"
DOCKER_WORKDIR="/var/www/html"
# Step 1: Clone the GitHub repository
echo "Cloning the GitHub repository..."
rm -rf $LOCAL_CODE_DIR
git clone $GITHUB_REPO $LOCAL_CODE_DIR
# Step 2: Delete the previous container if it exists
echo "Stopping and removing the existing container..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true
# Step 3: Delete the previous Docker image if it exists
echo "Removing the existing Docker image..."
docker rmi $IMAGE_NAME 2>/dev/null || true
# Step 4: Build the Docker image with the latest code
echo "Building the Docker image..."
docker build -t $IMAGE_NAME $LOCAL_CODE_DIR
# Step 5: Run the Docker container
echo "Running the Docker container..."
docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME
# Step 6: Copy the GitHub repository code to the container
echo "Copying code to the container..."
docker cp $LOCAL_CODE_DIR/. $CONTAINER_NAME:$DOCKER_WORKDIR
echo "Done!"
