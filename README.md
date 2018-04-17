Jmeter Cluster Performance Test
========

This is has been done for quite some time and I'm still try to locate and clean up the scripts.

## Architect
![Architect](https://raw.githubusercontent.com/changli3/jmeter-cluster-performance-test/master/jmeter-cluster-performance-test.png "Architect")

```
aws cloudformation deploy --stack-name jmetercontroller01 --template-file cf.yml --parameter-overrides  allowIPs="0.0.0.0/0" --capabilities CAPABILITY_IAM
```
Now you can logon to the controller. You have to do the following setups manually:

### Step 1. Prepare keypaire file

Copy your private key to the ~/.ssh/keypair.pem

```
chmod 400 ~/.ssh/keypair.pem
ssh-agent bash 
ssh-add ~/.ssh/keypair.pem 
```

### Step 2. Revise the Ansible Playbook
* The variables are in ./jmeter-cluster-performance-test/ec2_vars/config.yml
* Set multiple regions in ~/ec2.ini
* If you need to use public IP, you need to update ~/ec2.ini to reflect this. In my environment, all my VPCs are inter-connected with VPN tunnels.


### Step 3. Starts the Jmeter Nodes
```
ansible-playbook -i localhost provision-jmeter.yml
```

### Step 4. Build the Ansible Host Inventory
```
./ec2.py --refresh-cache
```

### Step 5. Test the connection
```
ansible -i ec2.py tag_Name_JmeterNode -m ping --private-key=~/.ssh/keypair.pem -u ubuntu
```

If everything works, you should get something like this -
![ping](https://raw.githubusercontent.com/changli3/jmeter-cluster-performance-test/master/ping.png "ping")

### Step 6. Provision Jmeter Test Script
Put your Jmeter test script (jmx file) to the server, and copy it to all the nodes with following command -
```
./provision-task.sh YOU-FILE.jmx
```

### Step 7. Run the Test
Start the performance test with the following command, where duration is in seconds -
```
./start-task-controller.sh TEST-NAME DURATION-LENGTH
```

### Step 8. Stop the Test
If you need to stop the test in the middle before it finishes -
```
./kill-task-controller.sh
```

### Step 9. Check the Dashboard Report
After the test, the Dashboard Reports are in the S3 bucket and are organized as. The reports should be viewable from the allowedIPs when you start the CloudFormation template.
```
Bucket
  Test Name
    Machine Name
	  index.html
	  ...
	   ...
```

### Step 10. To Stop all Jmeter Nodes
```
ansible-playbook -i ./ec2.py stop-jmeter.yml
```

### Step 11. To Start all Jmeter Nodes after Stop
```
ansible-playbook -i ./ec2.py start-jmeter.yml
```

### Step 12. To Terminate all Jmeter Nodes
```
ansible-playbook -i ./ec2.py terminate-jmeter.yml
```

### Missing Parts
I have the CloudWatch Dashboard set up to monitor the CPU and Network I/O for all the instances. I set up manually but have to turn them into scripts. So it's still missing here...

