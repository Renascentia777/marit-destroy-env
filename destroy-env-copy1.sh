#! /bin/bash

INSTANCEIDS=`aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId]' | awk '{print $1}'`

aws autoscaling detach-instances --instance-ids $INSTANCEIDS --auto-scaling-group-name Moses --should-decrement-desired-capacity

sleep 5m

aws autoscaling delete-auto-scaling-group --auto-scaling-group-name Moses

aws autoscaling delete-launch-configuration --launch-configuration-name Filippos

aws elb delete-load-balancer --load-balancer-name Saul

aws ec2 terminate-instances --instance-ids $INSTANCEIDS
