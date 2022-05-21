#!/bin/bash
#This base is take from repo https://gist.github.com/fredhsu/f3d927d765727181767b3b13a3a23704
# Download and Run : wget -O - https://raw.githubusercontent.com/DuwanSierra/kubernetes-learning/main/install-dns-and-docker-ubuntu.sh | bash
# 1. Install avahi-daemon
sudo apt-get update -y
sudo apt-get install -y avahi-daemon
# 2. Install Docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo docker run hello-world
# 3. Linux post-install add permissions
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

# 4. Install rancher in single node docker
while getopts r: flag
do
    case "${flag}" in
        r) rancher=${OPTARG};;
    esac
done
echo "Install rancher: $rancher";
if [ $rancher ]
then
  docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest
fi