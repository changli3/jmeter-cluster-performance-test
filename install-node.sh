apt-get -y update
apt -y install ansible awscli git python-pip wget
pip install boto
pip install --upgrade pip
cd /home/ubuntu
wget https://raw.githubusercontent.com/changli3/jmeter-cluster-performance-test/master/run-task-node.sh
wget https://raw.githubusercontent.com/changli3/jmeter-cluster-performance-test/master/kill-task-node.sh

chmod +x run-task-node.sh
chmod +x kill-task-node.sh

wget http://mirror.stjschools.org/public/apache//jmeter/binaries/apache-jmeter-4.0.tgz
tar zxvf apache-jmeter-4.0.tgz