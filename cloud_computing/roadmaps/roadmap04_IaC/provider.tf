# Terraform Openstack deployment
# Author: Tiago Demay - tiagoaodc@insper.edu.br


# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}


# Configure the OpenStack Provider

provider "openstack" {
  cacert_file         ="/home/cloud/snap/openstackclients/common/root-ca.crt"
  auth_url            = "https://192.168.0.120:5000/v3"
  region              = "RegionOne"
  user_name           = "admin"
#  password            = "PASSWORD_USER"
}
