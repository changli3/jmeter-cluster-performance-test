Jmeter Cluster Performance Test
========

This is has been done for quite some time and I'm still try to locate and clean up the scripts.

## Architect
![Architect](https://raw.githubusercontent.com/changli3/jmeter-cluster-performance-test/master/jmeter-cluster-performance-test.png "Architect")

```
aws cloudformation deploy --stack-name JmeterController01 --template-file cf.yml --parameter-overrides  allowIPs="0.0.0.0/0" --capabilities CAPABILITY_IAM
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
ansible-playbook -i localhost start-jmeter.yml
```

### Step 5. Build the Inventory
```
./ec2.py --refresh-cache
```

### Step 6. Test the connection
```
ansible -i ec2.py tag_Name_JmeterNode -m ping --private-key=~/.ssh/keypair.pem -u ec2-user
```

If everything works, you should get something like this -
![ping](https://raw.githubusercontent.com/changli3/jmeter-cluster-performance-test/master/ping.png "ping")
### Step 7. Provision Jmeter


### Step 8. Provision Jmeter Test Script


### Step 9. Run the test


### Step 10. Run the test

### Step 11. Shut down then system

