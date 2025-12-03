# 🗄️ Infraestrutura do Banco de Dados

Este repositório contém a infraestrutura de banco de dados para o projeto Fastfood, provisionada via **Terraform** na AWS. Inclui:

- Instância RDS (PostgreSQL)
- Security Group dedicado
- Integração com **AWS Secrets Manager** para credenciais
- Backend remoto em S3

---

## 📦 Estrutura do Projeto

```text
infra-database-fase4/
│── main.tf                # Configuração principal e orquestração dos módulos
│── variables.tf           # Variáveis globais do projeto
│── terraform.tfvars       # Valores das variáveis (exceto secrets)
│── providers.tf           # Providers necessários (AWS, PostgreSQL)
│── datasource.tf          # Data source para estados remotos
│── backend.tf             # Configuração do backend remoto S3
│── modules/               # Módulos reutilizáveis
│   ├── postgres/          # Módulo de criação de databases PostgreSQL
│   ├── rds/               # Módulo de RDS
│   ├── security-group/    # Módulo de Security Group
│   └── secrets-manager/   # Módulo de Secrets Manager
```

---

## ⚙️ Pré-requisitos

- [Terraform >= 1.6](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI configurado
- VPC e subnets privadas já provisionadas [infra-database-fase4](https://github.com/FIAP-SOAT-G129/infra-database-fase4)
- Secrets para credenciais da instancia RDS (usuário/senha)
- Secrets para credenciais dos bancos (usuário/senha/nome do banco)

---

## 🚀 Como usar

### 1. Inicializar o Terraform

```bash
terraform init
```

### 2. Validar a configuração

```bash
terraform validate
```

### 3. Planejar alterações

```bash
terraform plan -var-file="terraform.tfvars" -var-file="secrets.tfvars"
```

### 4. Aplicar alterações

```bash
terraform apply -var-file="terraform.tfvars" -var-file="secrets.tfvars"
```

---

## 🔑 Backend remoto

O estado do Terraform (`terraform.tfstate`) é armazenado no bucket S3:

- **Bucket:** `fastfood-tf-states`
- **Folder:** `infra/database/`

A configuração completa está no arquivo `backend.tf`.

---

## 🔑 Gestão de credenciais

- O usuário e senha do RDS são definidos via **AWS Secrets Manager** (módulo `secrets-manager`).
- No pipeline, o secret é exportado para um arquivo `secrets.tfvars`, consumido pelo Terraform.
- Nunca armazene senhas diretamente no repositório.

Exemplo de `secrets.tfvars`:

```hcl
master_username = "admin_user"

master_password = "Senha-Segura$123!"

databases = {
  db_1 = {
    username = "db1_user"
    password = "db1Senha@123"
  }

  db_2 = {
    username = "db2_user"
    password = "db2Senha@123"
  }
}

```

## 🏗️ Pipeline de Automação

O projeto utiliza pipelines CI/CD no GitHub Actions para garantir a automação, qualidade e segurança do provisionamento da infraestrutura. Os principais workflows estão em `.github/workflows/`:

- **fmt-validate.yml**: Executa `terraform fmt` e `terraform validate` em todos os PRs e pushes, garantindo que o código esteja formatado e válido antes de ser aplicado.

- **apply.yml**: Aplica as alterações aprovadas na infraestrutura (`terraform apply`) após revisão e aprovação do plano.

- **destroy.yml**: Automatiza a destruição dos recursos provisionados, geralmente utilizado para ambientes temporários ou de testes.
  
### Benefícios da automação

- Reduz erros manuais e aumenta a rastreabilidade
- Garante validação e revisão antes de qualquer alteração
- Permite auditoria e histórico de mudanças
- Facilita rollback e destruição controlada de recursos

Consulte cada arquivo em `.github/workflows/` para detalhes e personalizações.
