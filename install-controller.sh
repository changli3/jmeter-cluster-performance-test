apt-get -y update
apt -y install ansible awscli git python-pip
pip install boto
pip install --upgrade pip

cd /home/ubuntu
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
wget https://raw.githubusercontent.com/changli3/elk-prod-cluster/master/ec2.ini
chmod +x ec2.py

echo 'export ANSIBLE_HOSTS=/home/ubuntu/ec2.py' >> /home/ubuntu/.bashrc 
echo 'export EC2_INI_PATH=/home/ubuntu/ec2.ini' >> /home/ubuntu/.bashrc 


git clone https://github.com/changli3/jmeter-cluster-performance-test.git
cd jmeter-cluster-performance-test
echo $1 > ./s3bucket
chown -R ubuntu .
