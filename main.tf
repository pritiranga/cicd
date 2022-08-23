provider "aws" {
  region = var.location
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt = false
    bucket = "tf-state-s3"
    dynamodb_table = "tf-state-lock-dynamo"
    key = "path/path/terraform-tfstate"
    region = var.location
  }
}

resource "aws_vpc" "tf-test" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = ""
  tags = {
    Name = "tf_test"
  }
}

resource "aws_subnet" "Subnet-tf-public" {
  vpc_id = aws_vpc.tf-test
  cidr_block = "10.0.1.0/24"
  availability_zone = var.location
  tags = {
    "Name" = "Subnet-tf-public"
  }
}

resource "aws_subnet" "Subnet-tf-private" {
    vpc_id = aws_vpc.tf-test
    cidr_block = "10.0.2.0/24"
    availability_zone = var.location
    tags = {
      "Name" = "Subnet-tf-private"
    }
}



