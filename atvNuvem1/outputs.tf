output "ec2_public_ip" {
  description = "Endereço público da instância EC2"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "Endpoint do banco de dados RDS"
  value       = module.rds.db_endpoint
}
