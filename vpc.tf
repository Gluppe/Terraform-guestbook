resource "aws_vpc" "main" {
    # CIDR block for the VPC
    cidr_block = "192.168.0.0/16"
    
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