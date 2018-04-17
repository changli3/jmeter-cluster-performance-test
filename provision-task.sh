ansible -i ec2.py tag_Name_JmeterNode -m copy -a "src=$1 dest=/home/ubuntu/jemter-test.jmx" -f 10 --private-key=~/.ssh/keypair.pem -u ubuntu
