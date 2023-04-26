provider "aws" {
  region = var.region
}

resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "app_subnet" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = "10.0.1.0/24"
}

module "frontend" {
  source = "./modules/frontend"
  subnet_id = aws_subnet.app_subnet.id
}

module "backend" {
  source = "./modules/backend"
  subnet_id = aws_subnet.app_subnet.id
}

output "frontend_url" {
  value = module.frontend.frontend_url
}

