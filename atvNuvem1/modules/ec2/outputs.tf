output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "db_security_group_id" {
  value = aws_security_group.web_sg.id
}
