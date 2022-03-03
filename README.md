This sample shows how to setup up and use FSx with SageMaker Training. Repo contains 

- CFN template to launch the AWS infra
- Associates FSx with your data on S3
- How to use SageMaker training job to access data in FSx
- Tear the infra down and automatically save your training artifacts to S3

TLDR

Please make sure you read this [blog](https://aws.amazon.com/blogs/machine-learning/choose-the-best-data-source-for-your-amazon-sagemaker-training-job/) on if your use-case needs FSx so you can avoid operation costs.

Ideally you want zero operational overhead in large scale distributed training and Failing Fast should be your main objective. It is a expensive endeavor to train large scale models across the N state of the art GPU machines in a distributed manner. Minimizing the costs implies we want the fastest bootstrap cost to train model, low latency read (data load) and writes (training artifacts - especially as there will be quite a bit of experimentation in finding the right hyper parameters).