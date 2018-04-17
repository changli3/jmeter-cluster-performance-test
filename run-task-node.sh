HOME=/home/ubuntu
JMETERHOME=$HOME/apache-jmeter-4.0
cd $HOME
instance=$(curl http://169.254.169.254/latest/meta-data/instance-id)
rm -rf $instance
$JMETERHOME/bin/jmeter -n -t $HOME/jemter-test.jmx -l jemter-test.log &
sleep $1
output=`$JMETERHOME/bin/shutdown.sh`
sleep 180
mkdir $instance
$JMETERHOME/bin/jmeter -g jemter-test.log -o $instance
mv -f jemter-test.log $instance/jemter-test-results.log
aws s3 sync $instance s3://$2/$3
rm -f *.log
rm -f *.jmx
