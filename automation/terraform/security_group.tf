resource "aws_security_group" "front-app-sg" {
  vpc_id      = aws_vpc.ecommerce-project.id
  name        = "ecommerce-sg"
  description = "Group for front-app"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  tags = {
    Name = "app-sg"
  }
}

resource "aws_security_group" "grafana-sg" {
  vpc_id      = aws_vpc.ecommerce-project.id
  name        = "grafana-sg"
  description = "Group for grafana"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  tags = {
    Name = "grafana-sg"
  }
}

resource "aws_security_group" "databases-sg" {
  vpc_id      = aws_vpc.ecommerce-project.id
  name        = "databases-sg"
  description = "Group for databases"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  tags = {
    Name = "databases-sg"
  }
}

resource "aws_security_group" "ansible-sg" {
  vpc_id      = aws_vpc.ecommerce-project.id
  name        = "ansible-sg"
  description = "Group for ansible"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  tags = {
    Name = "ansible-sg"
  }
}