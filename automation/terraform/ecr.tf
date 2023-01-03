resource "aws_ecr_repository" "database" {
    name = "database"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository" "monitoring" {
    name = "monitoring"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository" "application" {
    name = "application"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}