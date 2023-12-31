resource "aws_vpc" "main" {
    # CIDR block for the VPC
    cidr_block = "10.0.0.0/16"
    
    # Instances shared across AWS accounts
    instance_tenancy = "default"
    
    # Required for EKS, enables dns support
    enable_dns_support = true
    
    # Required for EKS, enables dns hostnames
    enable_dns_hostnames = true
    
    tags = {
        Name = "main"
    }
}

resource "aws_subnet" "public_1" {
    
    # Id of the VPC where the subnet is created
    vpc_id = aws_vpc.main.id
    
    # CIDR block for the subnet
    cidr_block = "10.0.1.0/24"

    availability_zone = "eu-north-1a"
    
    # Required for eks, 
    map_public_ip_on_launch = true
    
    # Tags to define the resource
    tags = {
        Name                        = "public-eu-north-1a"
        "kubernetes.io/cluster/my_cluster" = "shared"
        "kubernetes.io/role/elb"    = 1
    }
    
}

resource "aws_subnet" "public_2" {
    
    # Id of the VPC where the subnet is created
    vpc_id = aws_vpc.main.id
    
    # CIDR block for the subnet
    cidr_block = "10.0.2.0/24"
    
    availability_zone = "eu-north-1b"
    
    # Required for eks, 
    map_public_ip_on_launch = true
    
    # Tags to define the resource
    tags = {
        Name                        = "public-eu-north-1b"
        "kubernetes.io/cluster/my_cluster" = "shared"
        "kubernetes.io/role/elb"    = 1
    }
    
}

resource "aws_subnet" "private_1" {
    
    # Id of the VPC where the subnet is created
    vpc_id = aws_vpc.main.id
    
    # CIDR block for the subnet
    cidr_block = "10.0.3.0/24"
    
    availability_zone = "eu-north-1a"
    
    # Tags to define the resource
    tags = {
        Name                        = "private-eu-north-1a"
        "kubernetes.io/cluster/my_cluster" = "shared"
        "kubernetes.io/role/elb"    = 1
    }
    
}

resource "aws_subnet" "private_2" {
    
    # Id of the VPC where the subnet is created
    vpc_id = aws_vpc.main.id
    
    # CIDR block for the subnet
    cidr_block = "10.0.4.0/24"
    
    availability_zone = "eu-north-1b"
    
    # Tags to define the resource
    tags = {
        Name                        = "private-eu-north-1b"
        "kubernetes.io/cluster/my_cluster" = "shared"
        "kubernetes.io/role/elb"    = 1
    }
    
}