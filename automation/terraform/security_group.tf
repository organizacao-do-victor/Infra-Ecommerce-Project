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

  ingress {
    description = "Front http port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Back http port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Prometheus port"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.grafana-project.public_ip}/32"]
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

  ingress {
    description = "Grafana port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Prometheus port"
    from_port   = 9090
    to_port     = 9090
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

  ingress {
    description = "Postgres Port"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Mongo Port"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Prometheus port"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.grafana-project.public_ip}/32"]
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

  ingress {
    description = "Prometheus port"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.grafana-project.public_ip}/32"]
  }

  tags = {
    Name = "ansible-sg"
  }
}