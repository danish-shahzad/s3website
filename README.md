# Completed Assignment Tasks:

- Main Task
• Use Terraform to provide a static website backed by an S3 bucket in AWS

- Additional points that you can cover to show your skills:
• Make your solution accessible globally with minimum delays and
minimum page load time. Hint: majority of site-users are located in
Australia. Let’s say that bucket with static content located in the region ‘EU
(Ireland) eu-west-1’
• Make your solution secure, so the users can be sure that their data
and personal information are safe.

# Pending Assignment Tasks:

Additional points that you can cover to show your skills:
1- Make your solution to be able to handle bucket-related errors. Hint:
your objects are not available because of the outage.

Advance level:
2- Provision additionally one EC2 instance. Allow changes to the site only
from that specific EC2 instance.

# Constraints
- Does not contain custom domain

# Instructions to Run the Project
1- Use Shell to setup environment:
2- use Terraform >=v1.2.1
3- Ensure you have exported environment variables, such as:
4- AWS_PROFILE set to a profile with appropriate privileges
5- AWS_REGION set to the desired region for resources that require the same

6- Run Commands:
$ terraform init
$ terraform plan
$ terraform apply

Once provisioned, it will output 2 things:
1- Bucket name
2- Domain name

***You can use domain name to see the website on browser.***

7- Other ways to retrieve the contents, as follows:

$ curl -L http://$(terraform output -raw domain_name)
Hello, World!

$ curl https://$(terraform output -raw domain_name)
Hello, World!