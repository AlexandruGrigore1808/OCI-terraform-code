# test-interview-repo
Terraform repository

With this terraform code you will deploy the following resources inside Oracle Cloud Infratructure:
- 1 VCN
- 2 Subnets: Public + Private
- 1 Internet gateway
- 1 NAT Gateway
- 2 Core instances
- 1 Block volume
- 1 Object storage bucket, Archive tier

Before running the code you need to fill the variables with: "to-be-filled"

Improvements to do:
- Create maps for variables, to pass the values
- Create outputs where is possible
- Have .tfvars file with the values to pass
