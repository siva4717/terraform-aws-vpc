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

# Create Public Subnets 1a and 1b 

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
  map_public_ip_on_launch = true 

  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-public-${local.availability_zones[count.index]}"
    }
  )
}


# Create Private Subnets 1a and 1b 

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
 

  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-private-${local.availability_zones[count.index]}"
    }
  )
}



# Create database Subnets 1a and 1b 

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
 

  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-database-${local.availability_zones[count.index]}"
    }
  )
}

