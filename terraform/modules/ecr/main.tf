resource "aws_ecr_repository" "app" {
  name = "my-ecr-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    environment = var.environment
  }
}


