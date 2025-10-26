# Create vpc

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = true 

  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-vpc"
    }
  )
}

# Create internet gateway {IGW}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-igw"
    }
  )
}



