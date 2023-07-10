terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.7"
        }
    }
}
 
provider "aws" {
    profile = "default"
    region = "ap-southeast-2"
}
 
resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    tags = {
        Name = var.tags
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_block
    availability_zone = var.public_subnet_az
    tags = {
        Name = var.public_subnet_tag
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_block
    availability_zone = var.private_subnet_az
    tags = {
        Name = var.private_subnet_tag
    }
}
 
 
resource "aws_network_acl" "public_subnet_nacl" {
    vpc_id = aws_vpc.main.id
    subnet_ids = [aws_subnet.public_subnet.id]

    egress = [
        {
            protocol = "tcp"
            rule_no = 200
            action = "allow"
            cidr_block = "10.3.0.0/18"
            from_port = 80
            to_port = 80
            icmp_code = 0
            icmp_type = 0
            ipv6_cidr_block = ""
        }
    ]
    
    ingress = [
        {
            protocol = "tcp"
            rule_no = 100
            action = "allow"
            cidr_block = "10.3.0.0/18"
            from_port = 80
            to_port = 80
            icmp_code = 0
            icmp_type = 0
            ipv6_cidr_block = ""
        }
    ]
    
    tags = {
        Name = "public_subnet_nacl"
    }
}   
 
resource "aws_network_acl" "private_subnet_nacl" {
    vpc_id = aws_vpc.main.id
    subnet_ids = [aws_subnet.private_subnet.id]
 
    egress = [
        {
            protocol = "tcp"
            rule_no = 300
            action = "allow"
            cidr_block = "10.3.0.0/18"
            from_port = 80
            to_port = 80
            icmp_code = 0
            icmp_type = 0
            ipv6_cidr_block = ""
        }
    ]
    
    ingress = [
        {
            protocol = "tcp"
            rule_no = 400
            action = "allow"
            cidr_block = "10.3.0.0/18"
            from_port = 80
            to_port = 80
            icmp_code = 0
            icmp_type = 0
            ipv6_cidr_block = ""
        }
    ]
    
    tags = {
        Name = "private_subnet_nacl"
    }
}
 
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "vpc_gateway"
    }
}
 
resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = "tf-public_subnet_rt"
    }
}
 
resource "aws_route_table_association" "rt_assoc" {
    route_table_id = aws_route_table.main.id
    subnet_id = aws_subnet.public_subnet.id
}
 
resource "aws_eip" "nat_ip" {
    tags = {
        Name = "EIP-for-NAT"
    }
}
 
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_ip.id
    subnet_id = aws_subnet.public_subnet.id
    
    tags = {
        Name = "TF-NAT-Gateway"
    }
}

resource "aws_route_table" "private_subnet_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
        Name = "tf-private-subnet-rt"
    }
}

resource "aws_route_table_association" "rt_assoc_private" {
    route_table_id = aws_route_table.private_subnet_rt.id
    subnet_id = aws_subnet.private_subnet.id
}
