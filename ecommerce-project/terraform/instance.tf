resource "aws_key_pair" "ecommerce-key" {
  key_name   = var.PRIV_KEY
  public_key = file("${var.PUB_KEY}")
}


resource "aws_instance" "front-app-project" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecommerce-project-pub-1.id
  key_name               = aws_key_pair.ecommerce-key.key_name
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
  key_name               = aws_key_pair.ecommerce-key.key_name
  vpc_security_group_ids = [aws_security_group.grafana-sg.id]
  tags = {
    Name    = "grafana-project"
    Project = "ecommerce-project"
  }
}

resource "aws_instance" "databases-project" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecommerce-project-priv-1.id
  key_name               = aws_key_pair.ecommerce-key.key_name
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
  key_name               = aws_key_pair.ecommerce-key.key_name
  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  tags = {
    Name    = "ansible-project"
    Project = "ecommerce-project"
  }
}
output "PublicIP" {
  value = ["front app: ", aws_instance.front-app-project.public_ip, "grafana: ", aws_instance.grafana-project.public_ip,
    "databases: ", aws_instance.databases-project.public_ip, "ansible: ", aws_instance.ansible-project.public_ip
  ]
}
