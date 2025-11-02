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
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true 

  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-public-${local.az_names[count.index]}"
    }
  )
}


# Create Private Subnets 1a and 1b 

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
 

  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-private-${local.az_names[count.index]}"
    }
  )
}



# Create database Subnets 1a and 1b 

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
 

  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-database-${local.az_names[count.index]}"
    }
  )
}


# Create public route table 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-public"
    }
  )

}


# Create private route table 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-private"
    }
  )
}

# Create database route table 
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-database"
    }
  )
}


# Create public route

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# Create elastic ip
resource "aws_eip" "nat" {
  domain           = "vpc"
  tags = merge(
    var.elastic_ip_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-elastic-ip"
    }
  )
}

# Create nat gate way

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.ngw_tags,
    local.common_tags,
    {
        Name="${local.common_name_suffix}-ngw"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}



# create private egress through nat
resource "aws_route" "private" {
  route_table_id              = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id

}

# create database egress through nat
resource "aws_route" "database" {
  route_table_id              = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id

}


# create public subnet id
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index]
  route_table_id = aws_route_table.public.id
}

# create private subnet id
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index]
  route_table_id = aws_route_table.private.id
}

# create database subnet id
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index]
  route_table_id = aws_route_table.database.id
}






