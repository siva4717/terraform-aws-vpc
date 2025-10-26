### Terraform AWS VPC Module

This module creates AWS VPC Module

### Inputs

project_name (Required) --> user must supply project_name for vpc 


environment (Required) --> user must supply environment for vpc 


cidr_block (Required) --> user must supply cidr_block 

vpc_tags (Optional)  --> vpc_tags are optional

public_subnet_cidrs (Required) --> user must supply two public_subnet_cidrs

public_subnet_tags (Optional) --> public_subnet_tags are optional

private_subnet_cidrs (Required) --> user must supply two private_subnet_cidrs

private_subnet_tags (Optional) --> private_subnet_tags are optional

database_subnet_cidrs (Required) --> user must supply two database_subnet_cidrs

database_subnet_tags (Optional) --> database_subnet_tags are optional



### Outputs

vpc_id --> This resource gives vpc_id