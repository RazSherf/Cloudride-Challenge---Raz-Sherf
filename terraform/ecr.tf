resource "aws_ecr_repository" "hello_world_repo" {
  name = "hello-world-repo"

#  Enables security scanning for images.
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "hello-world-ecr"
    Environment = "dev"
  }
}