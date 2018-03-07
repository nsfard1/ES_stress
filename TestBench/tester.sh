#!/bin/bash
# relies on following environment variables:
# $ES - absolute path to directory containing elasticsearch-6.2.1 folder
# input: port, python script
# output for python program will be written to ./tester.out
# clean option tears down the cluster
#
# Example: ./tester.sh 9300 prog.py
# Above will start an elasticsearch cluster on machines 11, 12, and 13 and then run "prog.py" on machine 11 with the cluster running through port 9300
#
# Example: ./tester.sh clean 
# Above will tear down the cluster

[ -z "$ES" ] && echo "Need to set ES" && exit 1;
d=$PWD

cd $ES
if [ $1 != "clean" ]; then
[ -z "$2" ] && echo "no python program supplied" && exit 1;
rm -rf machines
mkdir machines
cd machines
for i in `seq 11 13`;
do
        mkdir $i
        printf "$i\n" >> machine_list.txt
        cd $i
        cp -r $ES/elasticsearch-6.2.1 .
        echo "node.name: 127x$i" >> elasticsearch-6.2.1/config/elasticsearch.yml
        echo "path.logs: $ES/machines/$i/logs" >> elasticsearch-6.2.1/config/elasticsearch.yml
        echo "path.data: $ES/machines/$i/data" >> elasticsearch-6.2.1/config/elasticsearch.yml
        let "ip=i+10"
        echo "network.host: 129.65.221.$ip" >> elasticsearch-6.2.1/config/elasticsearch.yml
        echo 'discovery.zen.ping.unicast.hosts: ["129.65.221.21", "129.65.221.22", "129.65.221.23"]' >> elasticsearch-6.2.1/config/elasticsearch.yml
        echo "http.port: $1" >> elasticsearch-6.2.1/config/elasticsearch.yml
        nohup ssh 127x${i}.csc.calpoly.edu "$ES/machines/$i/elasticsearch-6.2.1/bin/elasticsearch" &> out.txt < /dev/null &
        cd ..
done
cd ..
nohup ssh 127x11.csc.calpoly.edu "cd $d && python $2" &> tester.out < /dev/null &
else
cat machines/machine_list.txt | while read line
do
        pid=`nohup ssh 127x${line}.csc.calpoly.edu "ps -ef | grep /bin/java | grep $USER | grep elasticsearch" &> /dev/null < /dev/null &`
        pid=`echo $pid | awk -F'[: ]+' '{ print $2 }'`

        for i in $pid;
        do
                nohup ssh 127x${line}.csc.calpoly.edu "kill -9 $i" &> /dev/null < /dev/null &
        done
done
rm -rf machines
fi