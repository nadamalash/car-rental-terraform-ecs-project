# Environment Variables

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment of the project."
  type        = string
}

# VPC Variables
variable "vpc_cidr" {
  description = "VPC CIDR Block."
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "Public Subnet AZ1 CIDR Block."
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "Public Subnet AZ2 CIDR Block."
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "Private App Subnet AZ1 CIDR Block."
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "Private App Subnet AZ2 CIDR Block."
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "Private Data Subnet AZ1 CIDR Block."
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "Private Data Subnet AZ2 CIDR Block."
  type        = string
}

# Security Groups Variables
variable "ssh_location" {
  description = "IP address that can ssh into servers."
  type        = string
}

# RDS Variables
variable "database_instance_class" {
  description = "Database Instance Type."
  type        = string
}

variable "multi_az_deployment" {
  description = "Create a Standby DB Instance."
  type        = bool
}

variable "database_snapshot_identifier" {
  description = "Database Snapshot Name."
  type        = string
}

variable "database_instance_identifier" {
  description = "Database Instance Identifier."
  type        = string
}

# S3 Variables
variable "env_file_bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

variable "env_file_name" {
  description = "env file name"
  type        = string
}