# terraform {
#   backend "s3" {
#     bucket         = "foz-terraform-state-bucket"
#     key            = "infra.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#   }
# }