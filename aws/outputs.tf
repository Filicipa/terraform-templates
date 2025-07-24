output "vpc_id" {
  value = data.aws_vpc.selected.id
}

output "public_ip" {
  description = "public ip of ec2"
  value       = aws_instance.this.public_ip
}

# output "elastic_ip" {
#   description = "Elastic IP for instance"
#   value       = aws_eip.this.public_ip
# }
