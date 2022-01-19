// @ General Notes
    // # EC2 = virtual servers
    // # The three cloud computing deployment models are 
        // cloud-based 
        // on-premises
        // hybrid

    // # EC2 Amazon Elastic Compute Cloud (Amazon EC2)
        // You can provision and launch an Amazon EC2 instance within minutes.
        // You can stop using it when you have finished running a workload.
        // You pay only for the compute time you use when an instance is running, not when it is stopped or terminated.
        // You can save costs by paying only for server capacity that you need or want.

        // On-Demand
            // On-Demand Instances are ideal for short-term, irregular workloads that cannot be interrupted. No upfront costs or minimum contracts apply. The instances run continuously until you stop them, and you pay for only the compute time you use.
            // Sample use cases for On-Demand Instances include developing and testing applications and running applications that have unpredictable usage patterns. On-Demand Instances are not recommended for workloads that last a year or longer because these workloads can experience greater cost savings using Reserved Instances.
        // Amazon EC2 Savings Plans // * 66% off
            // AWS offers Savings Plans for several compute services, including Amazon EC2. Amazon EC2 Savings Plans enable you to reduce your compute costs by committing to a consistent amount of compute usage for a 1-year or 3-year term. This term commitment results in savings of up to 66% over On-Demand costs.
            // * Any usage up to the commitment is charged at the discounted plan rate (for example, $10 an hour). Any usage beyond the commitment is charged at regular On-Demand rates.
            // Later in this course, you will review AWS Cost Explorer, a tool that enables you to visualize, understand, and manage your AWS costs and usage over time. If you are considering your options for Savings Plans, AWS Cost Explorer can analyze your Amazon EC2 usage over the past 7, 30, or 60 days. AWS Cost Explorer also provides customized recommendations for Savings Plans. These recommendations estimate how much you could save on your monthly Amazon EC2 costs, based on previous Amazon EC2 usage and the hourly commitment amount in a 1-year or 3-year plan.
        // Reserved Instances 
            // Reserved Instances are a billing discount applied to the use of On-Demand Instances in your account. You can purchase Standard Reserved and Convertible Reserved Instances for a 1-year or 3-year term, and Scheduled Reserved Instances for a 1-year term. You realize greater cost savings with the 3-year option.
            // At the end of a Reserved Instance term, you can continue using the Amazon EC2 instance without interruption. However, you are charged On-Demand rates until you do one of the following:
            // Terminate the instance.
            // Purchase a new Reserved Instance that matches the instance attributes (instance type, Region, tenancy, and platform).
        // Spot Instances // * 90% off
            // Spot Instances are ideal for workloads with flexible start and end times, or that can withstand interruptions. Spot Instances use unused Amazon EC2 computing capacity and offer you cost savings at up to 90% off of On-Demand prices.
            // Suppose that you have a background processing job that can start and stop as needed (such as the data processing job for a customer survey). You want to start and stop the processing job without affecting the overall operations of your business. If you make a Spot request and Amazon EC2 capacity is available, your Spot Instance launches. However, if you make a Spot request and Amazon EC2 capacity is unavailable, the request is not successful until capacity becomes available. The unavailable capacity might delay the launch of your background processing job.
            // After you have launched a Spot Instance, if capacity is no longer available or demand for Spot Instances increases, your instance may be interrupted. This might not pose any issues for your background processing job. However, in the earlier example of developing and testing applications, you would most likely want to avoid unexpected interruptions. Therefore, choose a different EC2 instance type that is ideal for those tasks.
        // Dedicated Hosts
            // Dedicated Hosts are physical servers with Amazon EC2 instance capacity that is fully dedicated to your use. 
            // You can use your existing per-socket, per-core, or per-VM software licenses to help maintain license compliance. You can purchase On-Demand Dedicated Hosts and Dedicated Hosts Reservations. Of all the Amazon EC2 options that were covered, Dedicated Hosts are the most expensive.

    // # Scalability***
        // Scalability involves beginning with only the resources you need and designing your architecture to automatically respond to changing demand by scaling out or in. As a result, you pay for only the resources you use. You don’t have to worry about a lack of computing capacity to meet your customers’ needs.
        
        // If you wanted the scaling process to happen automatically, which AWS service would you use? The AWS service that provides this functionality for Amazon EC2 instances is Amazon EC2 Auto Scaling.
            // * Amazon EC2 Auto Scaling

        // Dynamic scaling responds to changing demand. 
        // Predictive scaling automatically schedules the right number of Amazon EC2 instances based on predicted demand.
    
    // # Elastic Load Balancing***
        // Elastic Load Balancing is the AWS service that automatically distributes incoming application traffic across multiple resources, such as Amazon EC2 instances. 

    // # Messaging and queuing***
        // like jobs and queues 
        
        // Amazon Simple Notification Service (Amazon SNS) is a publish/subscribe service. Using Amazon SNS topics, a publisher publishes messages to subscribers. This is similar to the coffee shop; the cashier provides coffee orders to the barista who makes the drinks.

        // In Amazon SNS, subscribers can be web servers, email addresses, AWS Lambda functions, or several other options. 

        // * Amazon Simple Notification Service (Amazon SNS)
        // * Amazon Simple Queue Service (Amazon SQS)
    
    // # AWS Lambda
        // AWS Lambda is a service that lets you run code without needing to provision or manage servers.

    // # Amazon Elastic Container Service (Amazon ECS)
        // Amazon Elastic Container Service (Amazon ECS) is a highly scalable, high-performance container management system that enables you to run and scale containerized applications on AWS. 

    // # Amazon Elastic Kubernetes Service (Amazon EKS)
        // Amazon Elastic Kubernetes Service (Amazon EKS) is a fully managed service that you can use to run Kubernetes on AWS. 

    // # AWS Fargate***
        // AWS Fargate is a serverless compute engine for containers. It works with both Amazon ECS and Amazon EKS. 

        // When using AWS Fargate, you do not need to provision or manage servers. AWS Fargate manages your server infrastructure for you. You can focus more on innovating and developing your applications, and you pay only for the resources that are required to run your containers.

    // # Notes
        // The term “serverless” means that your code runs on servers, but you do not need to provision or manage these servers. 


    // @ networking
        // # virtual private cloud (VPC)
            // # Internet gateway
                // To allow public traffic from the internet to access your VPC, you attach an internet gateway to the VPC.
            // # Virtual private gateway - VPN
            // # AWS Direct Connect - direct fiber cables

        // # access control list (ACL)
        // # Security groups - EC2 instance

        // # Amazon Route 53 - DNS resolver

        // # Amazon CloudFront - CDN

    // @ storage

        // # Instance stores - with EC2 instance
            // Block-level storage volumes behave like physical hard drives.

        // # Amazon Elastic Block Store (Amazon EBS)
            // is a service that provides block-level storage volumes that you can use with Amazon EC2 instances. If you stop or terminate an Amazon EC2 instance, all the data on the attached EBS volume remains available.
            // # EBS snapshot
            // to back up an Amazon EBS
            // An EBS snapshot is an incremental backup

        // # Amazon Simple Storage Service (Amazon S3)