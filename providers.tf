# Configure aws provider to establish a secure connection between terraform and aws.
provider "aws" {
  region  = var.region
  profile = "terraform-user"
  
  # Adding these tags to those resources.
  default_tags {
    tags  = {
      "Automation"  = "terraform"       # resource created with terraform
      "Project"     = var.project_name  # resource belonged to this project
      "Environment" = var.environment
    }
  }
}