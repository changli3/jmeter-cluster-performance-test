ansible -i ec2.py tag_Name_JmeterNode -m shell -a "/home/ubuntu/kill-task-node.sh" -f 10 --private-key=~/.ssh/keypair.pem -u ubuntu
