provider "aws" {
    region = "eu-north-1"
}

provider "terrafrom" {
    backend = "s3"
}