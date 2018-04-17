apt-get -y update
apt -y install ansible awscli git python-pip
pip install boto
pip install --upgrade pip

cd /home/ubuntu
git clone https://github.com/changli3/jmeter-cluster-performance-test.git
cd jmeter-cluster-performance-test

wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
wget https://raw.githubusercontent.com/changli3/elk-prod-cluster/master/ec2.ini
chmod +x ec2.py
chown -R ubuntu .
echo 'export ANSIBLE_HOSTS=/home/ubuntu/ec2.py' >> /home/ubuntu/.bashrc 
echo 'export EC2_INI_PATH=/home/ubuntu/ec2.ini' >> /home/ubuntu/.bashrc 

echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
echo "$1-report" > ./s3bucket

sed -i "s/PROFILE/$2/" ec2_vars/config.yml