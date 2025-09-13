# Terraform infra - VPC, EC2 (Apache), RDS MySQL, S3 backend
Aluno = LMF
Periodo = 8

Estrutura de módulos:
- modules/vpc
- modules/ec2
- modules/rds
- modules/s3_backend

**Notas de uso**
1. Primeiro crie o bucket S3 que será usado como backend (veja `modules/s3_backend`). Recomendo executar `terraform init` e `terraform apply` dentro de `modules/s3_backend` para criar o bucket.
2. Depois atualize `backend.tf` no diretório raiz com o nome do bucket criado (ou use a variável `backend_bucket`), então execute `terraform init` no diretório raiz. O backend S3 precisa do bucket existente antes de `terraform init` com o backend configurado.
3. Configure suas credenciais AWS (ex: AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY) e `aws` region na variável `aws_region` ou via provider config.
4. `terraform apply` no diretório raiz para provisionar VPC, EC2 e RDS.

Arquivo gerado automaticamente para entrega em zip.
