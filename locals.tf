locals{
  common_tags={
    Project=var.project_name
    Environment=var.environment
    Terraform=true
  }
  common_name_suffix="${var.project_name}-${var.environment}"
  availability_zones=slice(data.aws_availability_zones.available,0,2)
}

