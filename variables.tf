variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
  default = "default"
}

variable "vpc_tags" {
  type = map 
  default = {}
}

variable "igw_tags" {
  type = map 
  default = {}
}

variable "public_subnet_cidrs" {
  type = list 
}
variable "public_subnet_tags" {
  type = map 
  default = {}
}

variable "private_subnet_cidrs" {
  type = list 
}
variable "private_subnet_tags" {
  type = map 
  default = {}
}

variable "database_subnet_cidrs" {
  type = list 
}
variable "database_subnet_tags" {
  type = map 
  default = {}
}

variable "public_route_table_tags" {
  type = map 
  default = {}
}

variable "private_route_table_tags" {
  type = map 
  default = {}
}

variable "database_route_table_tags" {
  type = map 
  default = {}
}

variable "elastic_ip_tags" {
  type = map 
  default = {}
}

variable "ngw_tags" {
  type = map 
  default = {}
}

