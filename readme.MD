# Terraform AWS VPC

This module creates the following resources.
* VPC
* IGW
* 2 Public subnets in us-east-1a and us-east-1b AZ
* 2 Private subnets in us-east-1a and us-east-1b AZ
* 2 Database subnets in us-east-1a and us-east-1b AZ
* Public Route table
* Private Route table
* Database Route table
* EIP for NAT
* NAT Gateway in public subnet 1a az
* IGW route is added to public route table
* NAT gateway route to private and database route tables
* Route table association with subnets
* VPC to default VPC peering
* Public route table to default VPC route
* Default VPC main route table to created VPC route

### Inputs

* vpc_cidr - (Required). User must supply the CIDR for VPC.
* project_name - (Required). User must supply the project nae.

### Outputs

* vpc_id it gives resource vpc id
* public_subnet_id
* private_subnet_id
* database_subnet_id
* public_route_table_id
* private_route_table_id
* database_route_table_id
