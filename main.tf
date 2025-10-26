resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = true 
  instance_tenancy = var.instance_tenancy

  tags = merge(
    local.common_tags,
    {
        Name="${local.common_name_suffix}-vpc"
    }
  )
}