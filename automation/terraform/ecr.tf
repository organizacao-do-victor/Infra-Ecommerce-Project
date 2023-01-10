resource "aws_ecr_repository" "mongo" {
    name = "mongo"
    image_tag_mutability = "MUTABLE"
    force_delete = true

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository" "postgres" {
    name = "postgres"
    image_tag_mutability = "MUTABLE"
    force_delete = true

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository" "monitoring" {
    name = "monitoring"
    image_tag_mutability = "MUTABLE"
    force_delete = true

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository" "node" {
    name = "node"
    image_tag_mutability = "MUTABLE"
    force_delete = true

    image_scanning_configuration {
      scan_on_push = true
    }
}