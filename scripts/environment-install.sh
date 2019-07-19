#!/bin/sh

# Install Build Tools
sudo /bin/date +%H:%M:%S > /home/$5/install.progress.txt

echo "Installing build-essential package" >> /home/$5/install.progress.txt
sudo apt install -y build-essential
sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt

echo "Installing packaging-dev package" >> /home/$5/install.progress.txt
sudo apt install -y packaging-dev
sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt


# Install MySQL building dependencies

echo "Installing MySQL building dependencies" >> /home/$5/install.progress.txt
sudo apt install -y bison libncurses5-dev zlib1g-dev pkg-config libjson-perl
sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt


# Install Docker Engine and Compose
echo "Installing Docker Engine and Compose" >> /home/$5/install.progress.txt
sudo apt update
sudo apt install -y apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce
sudo systemctl status docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $5

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt


# Install VSTS agent dependencies

echo "Installing VSTS agent dependencies" >> /home/$5/install.progress.txt
sudo apt install -y liblttng-ust0 libkrb5-3 zlib1g libcurl4 libssl1.0.0 libicu60
sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt


# Download VSTS agent and required security patch

echo "Downloading VSTS agent package" >> /home/$5/install.progress.txt

sudo -u $5 mkdir /home/$5/downloads
cd /home/$5/downloads

sudo -u $5 wget https://vstsagentpackage.azureedge.net/agent/$6/vsts-agent-linux-x64-$6.tar.gz

sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt


# Install VSTS agent

echo "Installing VSTS agent package" >> /home/$5/install.progress.txt

sudo -u $5 mkdir /home/$5/myagent
cd /home/$5/myagent
sudo -u $5 tar xzf /home/$5/downloads/vsts-agent-linux-x64-$6.tar.gz

echo "LANG=en_US.UTF-8" > .env
echo "export LANG=en_US.UTF-8" >> /home/$5/.bashrc
export LANG=en_US.UTF-8

echo URL: $1 > /home/$5/vsts.install.log.txt 2>&1
echo PAT: HIDDEN >> /home/$5/vsts.install.log.txt 2>&1
echo Pool: $3 >> /home/$5/vsts.install.log.txt 2>&1
echo Agent: $4 >> /home/$5/vsts.install.log.txt 2>&1
echo User: $5 >> /home/$5/vsts.install.log.txt 2>&1
echo Version: $6 >> /home/$5/vsts.install.log.txt 2>&1
echo =============================== >> /home/$5/vsts.install.log.txt 2>&1

echo Running Agent.Listener >> /home/$5/vsts.install.log.txt 2>&1
sudo -u $5 -E bin/Agent.Listener configure --unattended --nostart --replace --acceptTeeEula --url $1 --auth PAT --token $2 --pool $3 --agent $4 >> /home/$5/vsts.install.log.txt 2>&1
echo =============================== >> /home/$5/vsts.install.log.txt 2>&1
echo Running ./svc.sh install >> /home/$5/vsts.install.log.txt 2>&1
sudo -E ./svc.sh install $5 >> /home/$5/vsts.install.log.txt 2>&1
echo =============================== >> /home/$5/vsts.install.log.txt 2>&1
echo Running ./svc.sh start >> /home/$5/vsts.install.log.txt 2>&1

sudo -E ./svc.sh start >> /home/$5/vsts.install.log.txt 2>&1
echo =============================== >> /home/$5/vsts.install.log.txt 2>&1

sudo chown -R $5.$5 .*


echo "ALL DONE!" >> /home/$5/install.progress.txt
sudo /bin/date +%H:%M:%S >> /home/$5/install.progress.txt