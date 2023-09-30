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