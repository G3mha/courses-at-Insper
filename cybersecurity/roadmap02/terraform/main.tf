terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "vpc" {
  id = "vpc-0369397b553af8bcf"
}

// data source elastic ip
data "aws_eip" "eip_wazuh" {
  id = "eipalloc-09e1bc72ba9aba027"
}

data "aws_eip" "eip_jmp" {
  id = "eipalloc-0486c39e77f3465f3"
}

resource "aws_eip_association" "eip_wazuh_association" {
  instance_id   = aws_instance.ec2_wazuh.id
  allocation_id = data.aws_eip.eip_wazuh.id
}

resource "aws_eip_association" "eip_jmp_association" {
  instance_id   = aws_instance.ec2_jmp.id
  allocation_id = data.aws_eip.eip_jmp.id
}

// Create a EC2 with Ubuntu 22.04 LTS, 4GB RAM, 2 vCPUs
resource "aws_instance" "ec2_wazuh" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.medium"
  key_name      = "mykeypair"
  security_groups = ["sg-024a929a0fd9e830f"]
  associate_public_ip_address = true
  subnet_id = "subnet-00a39ca42e106ea3f"

  tags = {
    Name = "csp1-ec2-wazuh"
  }
}

resource "aws_instance" "ec2_jmp" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name      = "mykeypair"
  security_groups = ["sg-024a929a0fd9e830f"]
  associate_public_ip_address = true
  subnet_id = "subnet-00a39ca42e106ea3f"

  tags = {
    Name = "csp1-ec2-jmp"
  }
}
