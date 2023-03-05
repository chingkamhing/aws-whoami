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

## References:

* [AWS Tutorial: A Step-by-Step Tutorial for Beginners](https://www.simplilearn.com/tutorials/aws-tutorial)
* [AWS (Amazon Web Services) Tutorial: Basics for Beginners](https://www.guru99.com/aws-tutorial.html)
* ECR
    + [How to Build and Push Docker Images to AWS ECR](https://www.freecodecamp.org/news/build-and-push-docker-images-to-aws-ecr/)
* deploy to ECS
    + [What is Amazon Elastic Container Service?](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
    + [Deploying Microservices with Amazon ECS, AWS CloudFormation, and an Application Load Balancer](https://github.com/aws-samples/ecs-refarch-cloudformation)
    + [Step by Step Guide of AWS Elastic Container Service](https://towardsdatascience.com/step-by-step-guide-of-aws-elastic-container-service-with-images-c258078130ce)
    + [AWS EC2 CONTAINER SERVICE (ECS) & EC2 CONTAINER REGISTRY (ECR) | DOCKER REGISTRY](https://www.bogotobogo.com/DevOps/DevOps-ECS-ECR.php)
* bastion host
    + [How to Create a Bastion Host | Part 1 of a Step-by-step Tutorial](https://www.strongdm.com/blog/bastion-hosts-with-audit-logging-part-one#:~:text=What%20is%20a%20bastion%20host,to%20reduce%20their%20attack%20surface.)
