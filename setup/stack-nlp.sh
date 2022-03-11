#!/bin/bash

# AWS Region; customize as needed 
[[ -z "${AWS_REGION}" ]] && echo "AWS_REGION is required" && exit 1 

# AWS Availability Zone
[[ -z "${AWS_REGION_AZ}" ]] && echo "AWS_REGION_AZ is required" && exit 1 


if [ -z "$1" ]
  then
    echo "Please pass CFN stack name. ex - sh stack-nlp.sh nlp-large-scale-training"
    exit 1
fi

cd setup
DATE=`date +%s`

#Customize stack name as needed
STACK_NAME=$1
AWS_VPC_ID=$2
AWS_IGW_ID=$3
AWS_PUBLIC_SUBNET_CIDR_BLOCK=$4
AWS_PRIVATE_SUBNET_CIDR_BLOCK=$5

# cfn template name
CFN_TEMPLATE='cfn-nlp.yaml'


aws cloudformation create-stack --region $AWS_REGION  --stack-name $STACK_NAME \
--template-body file://$CFN_TEMPLATE \
--parameters \
ParameterKey=AZ,ParameterValue=$AWS_REGION_AZ ParameterKey=VPCID,ParameterValue=$AWS_VPC_ID ParameterKey=IGWID,ParameterValue=$AWS_IGW_ID ParameterKey=PUBLICSUBNETCIDRBLOCK,ParameterValue=$AWS_PUBLIC_SUBNET_CIDR_BLOCK ParameterKey=PRIVATESUBNETCIDRBLOCK,ParameterValue=$AWS_PRIVATE_SUBNET_CIDR_BLOCK

echo "Creating stack [ eta 600 seconds ]"
sleep 30

progress=$(aws --region $AWS_REGION cloudformation list-stacks --stack-status-filter 'CREATE_IN_PROGRESS' | grep $STACK_NAME | wc -l)
while [ $progress -ne 0 ]; do
let elapsed="`date +%s` - $DATE"
echo "Stack $STACK_NAME status: Create in progress: [ $elapsed secs elapsed ]"
sleep 30
progress=$(aws --region $AWS_REGION  cloudformation  list-stacks --stack-status-filter 'CREATE_IN_PROGRESS' | grep $STACK_NAME | wc -l)
done
sleep 5
aws --region $AWS_REGION  cloudformation describe-stacks --stack-name $STACK_NAME
