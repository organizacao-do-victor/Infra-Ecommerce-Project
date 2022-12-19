resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = var.KEY_NAME
  file_permission = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.KEY_NAME
  public_key = tls_private_key.key.public_key_openssh
}


resource "aws_instance" "front-app-project" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecommerce-project-pub-1.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.front-app-sg.id]
  tags = {
    Name    = "front-app-project"
    Project = "ecommerce-project"
  }
}

resource "aws_instance" "grafana-project" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecommerce-project-pub-2.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.grafana-sg.id]
  tags = {
    Name    = "grafana-project"
    Project = "ecommerce-project"
  }
}

resource "aws_instance" "databases-project" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecommerce-project-pub-1.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.databases-sg.id]
  tags = {
    Name    = "databases-project"
    Project = "ecommerce-project"
  }
}

resource "aws_instance" "ansible-project" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecommerce-project-pub-1.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  tags = {
    Name    = "ansible-project"
    Project = "ecommerce-project"
  }
}
