# AWS Whoami Project

The purpose of this project:

* familiar how to deploy to AWS
* how to use AWS gateway to access to the backend service
* how to use ECR to store docker image
* how to use ECS to deploy docker service
* how to use ELB to load balance the backend services
* how to use Route 53 (i.e. DNS) for service discovery
* how to make use of Let's Encrypt for SSL certificate; or use AWS Certificate Manager free public cert?

## whoami

* Small golang server to get the server's information

## Deploy to AWS

* build whoami docker and push to AWS ECR
* go to AWS Elastic Container Service
    + create ECS cluster
        - default VPC
        - check "Amazon EC2 instances"
    + create task definition
        - health check: "CMD-SHELL, curl -f http://localhost:8000/health || exit 1"
        - network mode: awsvpc
        - load balance type: Application Load Balancer
    + run new task
* go to EC2 > Load balancers
    + copy the DNS name
    + paste it to file ".env" environment variable "URL"
    + invoke "set -a; source .env; set +a"
    + invoke "./script/whoami.sh | jq ."
    ```shell
    kamching@kamching-envy17t:~/workspace/go/src/github.com/chingkamhing/aws-whoami$ ./script/whoami.sh | jq .
    {
      "Hostname": "ip-172-31-16-184.ap-southeast-1.compute.internal",
      "IPs": [
        "127.0.0.1",
        "169.254.172.2",
        "172.31.16.184"
      ],
      "Headers": {
        "Accept": "*/*",
        "User-Agent": "curl/7.85.0",
        "X-Amzn-Trace-Id": "Root=1-640a1258-140fa122090a94e0012a9008",
        "X-Forwarded-For": "1.64.103.176",
        "X-Forwarded-Port": "8000",
        "X-Forwarded-Proto": "http"
      }
    }

    ```

## References:

* [AWS Tutorial: A Step-by-Step Tutorial for Beginners](https://www.simplilearn.com/tutorials/aws-tutorial)
* [AWS (Amazon Web Services) Tutorial: Basics for Beginners](https://www.guru99.com/aws-tutorial.html)
* ECR
    + [How to Build and Push Docker Images to AWS ECR](https://www.freecodecamp.org/news/build-and-push-docker-images-to-aws-ecr/)
* deploy to ECS
    + [Tutorial: Using cluster auto scaling with the AWS Management Console and the Amazon ECS console](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/tutorial-cluster-auto-scaling-console.html)
    + [Deploy Nginx image by creating an AWS ECS cluster with an EC2 launch type](https://dev.to/aws-builders/deploy-nginx-image-by-creating-an-aws-ecs-cluster-with-an-ec2-launch-type-nb5)
    + [What is Amazon Elastic Container Service?](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
    + [Deploying Microservices with Amazon ECS, AWS CloudFormation, and an Application Load Balancer](https://github.com/aws-samples/ecs-refarch-cloudformation)
    + [Step by Step Guide of AWS Elastic Container Service](https://towardsdatascience.com/step-by-step-guide-of-aws-elastic-container-service-with-images-c258078130ce)
    + [AWS EC2 CONTAINER SERVICE (ECS) & EC2 CONTAINER REGISTRY (ECR) | DOCKER REGISTRY](https://www.bogotobogo.com/DevOps/DevOps-ECS-ECR.php)
* VPC
    + [Understanding Amazon VPC Terminology](https://levelup.gitconnected.com/understanding-amazon-vpc-terminology-b3150bb6cde0)
    + [Creating a Custom VPC in AWS](https://levelup.gitconnected.com/creating-a-custom-vpc-in-aws-b4ea7bf4a71)
    + [How to Create AWS VPC in 10 steps, less than 10 min](https://varunmanik1.medium.com/how-to-create-aws-vpc-in-10-steps-less-than-5-min-a49ac12064aa)
    + [Creating your own custom VPC](https://www.javatpoint.com/creating-your-own-custom-vpc)
* networking
    + [ECS Network Modes Comparison](https://tutorialsdojo.com/ecs-network-modes-comparison/)
    + [ECS Networking - (awsvpc, bridge, host, none)](https://dev.to/aws-builders/ecs-networking-awsvpc-bridge-host-none-4bg9)
* bastion host
    + [How to Create a Bastion Host | Part 1 of a Step-by-step Tutorial](https://www.strongdm.com/blog/bastion-hosts-with-audit-logging-part-one#:~:text=What%20is%20a%20bastion%20host,to%20reduce%20their%20attack%20surface.)
