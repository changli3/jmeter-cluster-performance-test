S3=`cat ./s3bucket`
TESTNAME=$1
TESTPERIOD=$2
ansible -i ec2.py tag_Name_JmeterNode -m shell -a "/home/ubuntu/run-task-node.sh $2 $S3 $1" -f 10 --private-key=~/.ssh/keypair.pem -u ubuntu
