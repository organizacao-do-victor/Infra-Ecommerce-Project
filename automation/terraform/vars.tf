variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0149b2da6ceec4bb0"
  }
}

variable "USER" {
  default = "ubuntu"
}

variable "KEY_NAME" {
  default = "ecommerce-key"
  type    = string
}

variable "MYANYWHERE" {
  default = "0.0.0.0/0"
}