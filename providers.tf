provider "aws" {
    # Specified in Git action, check main.yaml file for details
}

terraform {
    
    backend "s3" {
        # The backend is set up in the Git action, see main.yaml file
    }
    
    required_providers {
        aws = {
            source = "hashicorop/aws"
        }
    }
    
}
    
    