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

variable "public_subnet_tags" {
  type = map 
  default = {}
}