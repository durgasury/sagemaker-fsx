## SageMaker training with FSx

This sample repository shows how to setup up and use FSx with SageMaker Training. There are two branches - 
- `main`:  sets up a new VPC using CloudFormation and creates FSx within that VPC. 
- `with_existing_vpc`: the CloudFormation stack gets the VPC and subnet information as parameters, and creates the FSx within that VPC. Use this branch if you already have a VPC set up and have to operate within the given VPC. 

This repo contains a CFN template to launch the AWS infrastructure necessary. The notebook [training-fsx.ipynb](training-fsx.ipynb) has the necessary cells to launch the CFN stack, associate FSx with the training data on S3, and runs a training job that accesses your data in FSx. Finally, it also has instructions for cleanup to avoid unnecessary costs.

To run the notebook without any errors, make sure the following IAM policies are attached to the notebook's execution role.
- [AmazonFSxFullAccess](https://console.aws.amazon.com/iam/home#/policies/arn:aws:iam::aws:policy/AmazonFSxFullAccess)
- [NetworkAdministrator](https://console.aws.amazon.com/iam/home#/policies/arn:aws:iam::aws:policy/job-function/NetworkAdministrator)
- [AmazonSageMakerFullAccess](https://console.aws.amazon.com/iam/home#/policies/arn:aws:iam::aws:policy/AmazonSageMakerFullAccess)
- [AWSCloudFormationFullAccess](https://console.aws.amazon.com/iam/home#/policies/arn:aws:iam::aws:policy/AWSCloudFormationFullAccess)
- [FSx access to S3](https://docs.aws.amazon.com/fsx/latest/LustreGuide/setting-up.html#fsx-adding-permissions-s3)

#### TL;DR

Please make sure you read this [blog](https://aws.amazon.com/blogs/machine-learning/choose-the-best-data-source-for-your-amazon-sagemaker-training-job/) on if your use-case needs FSx so you can avoid operation costs.

Ideally, you want zero operational overhead in large scale distributed training and Failing Fast should be your main objective. It is a expensive endeavor to train large scale models across the N state of the art GPU machines in a distributed manner. Minimizing the costs implies we want the fastest bootstrap cost to train model, low latency read (data load) and writes (training artifacts - especially as there will be quite a bit of experimentation in finding the right hyper parameters).
