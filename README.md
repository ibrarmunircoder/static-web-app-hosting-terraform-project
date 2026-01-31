## <p style="text-align:center">🌐 Production-Ready React App on AWS using Terraform </p>

### Live Demo:

![Live Demo Screenshot](./screenshots/app-screenshot.png)

### Problem:

I have a company frontend application designed and developed using a modern React framework. To make it accessible to customers, the application needs to be deployed to an AWS environment. The company has a global presence across more than 20 countries and wants to ensure that users experience fast, reliable, and secure interactions with the application. However, managing and deploying cloud infrastructure manually can introduce human error, lead to inconsistent configurations, and make it difficult to scale and maintain the application efficiently.

### Architecture Diagram:

![Diagram 1](./screenshots/arch-1.png)
![Diagram 2](./screenshots/arch-2.png)

### 🚀 Overview:

This project demonstrates the end-to-end deployment of a production-ready React application on AWS using Terraform as Infrastructure as Code. The application is hosted on Amazon S3 for static asset storage and served globally through Amazon CloudFront for low-latency content delivery and HTTPS support. Terraform is used to provision and manage all AWS resources in a repeatable, version-controlled manner, showcasing best practices in cloud infrastructure automation, scalability, and security. This project highlights practical DevOps skills, including AWS architecture design, infrastructure automation, and modern frontend deployment workflows.

### ⚖️ Design Decisions:

As you know, we have multiple solutions for a same problem. We can use different services on AWS to deploy this application. We should architect our project based on the requirements we are given.

<strong>Amazon S3:</strong> Amazon S3 is used to host the React application’s static assets. Since the application is a static frontend, S3 allows us to store and serve files without provisioning or managing any underlying servers. S3 is highly scalable and highly available by design, automatically replicating data across multiple facilities to ensure durability and reliability. This makes it an ideal choice for storing frontend build artifacts.

<strong>Amazon CloudFront:</strong> While S3 supports static website hosting, serving a frontend application directly from S3 is not recommended for production use in terms of security, performance, and cost optimization. S3 does not natively support custom domains with HTTPS when used alone, and high request volumes can lead to increased costs, as pricing scales linearly with the number of requests and data transfer.

Amazon CloudFront addresses these limitations by acting as a global Content Delivery Network (CDN) in front of S3. CloudFront caches application assets at edge locations closest to users, significantly reducing latency for a globally distributed audience. It also enables secure access via HTTPS, supports custom domain names, reduces direct load on S3, and helps optimize costs by minimizing repeated origin requests. This combination ensures fast, secure, and scalable delivery of the application to users worldwide.

### 🎯 Learning Objectives

<ul>

<li>Understand how to deploy and host a React application using AWS S3 and CloudFront</li>
<li>Learn how to design globally available frontend architectures using a CDN</li>
<li>
Gain hands-on experience with Terraform for Infrastructure as Code (IaC)</li>
<li>Implement secure access patterns between CloudFront and S3</li>
</ul>
