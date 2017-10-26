#!/bin/bash

actdir=$PWD
cd ..
echo $PWD
layer_name=multi-is-layer
jobid_indx=0
jobstatus_indx=18

echo "installaing IS ..."
sagcc exec templates composite apply $layer_name -i ./$layer_name/$layer_name.properties environment.type=server is.host=cent1
jobstr=(`sagcc list jobmanager jobs | grep RUNNING | grep $layer_name`)
jobid=${jobstr[$jobid_indx]}
echo 'monitoring jobid '$jobid
jobstr=(`sagcc list jobmanager jobs $jobid`)
jobstatus=${jobstr[$jobstatus_indx]}
echo "status of job "$jobid": "$jobstatus 
while [ "$jobstatus" == "RUNNING" ];do
    echo -n "."
    sleep 10
    jobstr=(`sagcc list jobmanager jobs $jobid`)
    jobstatus="${jobstr[$jobstatus_indx]}"
done 
echo
sagcc list jobmanager jobs $jobid
echo
cd $actdir

