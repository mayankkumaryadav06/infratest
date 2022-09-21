variable "region" {
  description = "Region for deployment"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR range to be used for VPC"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched."
  default     = "default"
}


variable "client" {
  description = "Client for which infrastructure is to be created"
}

variable "environment" {
  description = "Environment for deployment"
  default     = "dev"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "frontend_app_port" {
  default = 80
}

variable "db_allocated_storage" {
  description = "Allocated storage for DB instances"
}

variable "db_engine" {
  description = "DB Engine. Ex: Postgres, MySQL"
  default     = "postgres"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  default     = "db.t3.micro"
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
  default     = "proddb"
}

variable "db_instance_name" {
  description = "The name of the database instance to create."
  type        = string
  default     = ""
}

variable "db_admin_username" {
  description = "Username for the master DB user."
  type        = string
  default     = "adminUser"
}

variable "db_admin_password" {
  description = "Password for the master DB user."
  type        = string
  default     = ""
}

variable "db_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "14.1"
}

variable "instance_asg_max" {
  description = "Max size for ASG"
  default     = 1
}

variable "instance_asg_min" {
  description = "Min size for ASG"
  default     = 1
}

variable "instance_asg_desired" {
  description = "Desired size for ASG"
  default     = 1
}