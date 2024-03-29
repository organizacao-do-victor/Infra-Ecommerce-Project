output "Bucket-name" {
  value = aws_s3_bucket.ecommerce.bucket_domain_name
}

output "Nginx-Public-IP" {
  value = aws_instance.nginx-project.public_ip
}
output "Front-App-Public-IP" {
  value = aws_instance.front-app-project.public_ip
}
output "Front-App-HS-Public-IP" {
  value = aws_instance.front-app-hs-project.public_ip
}
output "Grafana-Public-IP" {
  value = aws_instance.grafana-project.public_ip
}
output "Databases-Public-IP" {
  value = aws_instance.databases-project.public_ip
}
output "Ansible-Public-IP" {
  value = aws_instance.ansible-project.public_ip
}

output "AWS-ID" {
	value = data.aws_caller_identity.current.account_id
}

output "AWS-Region" {
	value = data.aws_region.current.name
}