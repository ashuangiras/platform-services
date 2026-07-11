terraform {
  required_version = "~> 1.9"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }

  # S3-compatible backend — same MinIO instance as platform-infrastructure.
  # Copy backend.hcl.example to backend.hcl and fill in credentials before:
  #   terraform init -backend-config=backend.hcl
  backend "s3" {}
}

provider "docker" {}
