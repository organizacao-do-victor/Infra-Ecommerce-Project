output "Bucket-name" {
  value = aws_s3_bucket.ecommerce.bucket_domain_name
}


output "Front-App-Public-IP" {
  value = aws_instance.front-app-project.public_ip
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