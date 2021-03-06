#!/bin/bash
#This base is take from repo https://gist.github.com/fredhsu/f3d927d765727181767b3b13a3a23704
# Download, Run, install Docker and run Rancher Server : wget -O - https://raw.githubusercontent.com/DuwanSierra/kubernetes-learning/main/install-dns-and-docker-ubuntu.sh | bash /dev/stdin -r true
# 1. Install avahi-daemon
sudo apt-get update -y
sudo apt-get install -y avahi-daemon
# 2. Install Docker
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo docker run hello-world
# 3. Linux post-install add permissions
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
# 4. Install nfs utils and nfs common
sudo apt install -y libnfs-utils
sudo apt-get install -y nfs-common
# 5. Install iscs
sudo apt-get install -y open-iscsi lsscsi sg3-utils multipath-tools scsitools

sudo tee /etc/multipath.conf <<-'EOF'
defaults {
    user_friendly_names yes
    find_multipaths yes
}
EOF

sudo systemctl enable multipath-tools.service
sudo service multipath-tools restart
sudo systemctl enable open-iscsi.service
sudo service open-iscsi start

# 4. Install rancher in single node docker
while getopts r: flag
do
    case "${flag}" in
        r) rancher=${OPTARG};;
    esac
done
echo "Install rancher: $rancher";
if [ $rancher -eq "true"]
then
  docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:stable
fi