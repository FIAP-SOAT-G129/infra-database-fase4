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
│── providers.tf           # Provider AWS
│── datasource.tf          # Data source para estados remotos
│── backend.tf             # Configuração do backend remoto S3
│── modules/               # Módulos reutilizáveis
│   ├── rds/               # Módulo de RDS
│   ├── security-group/    # Módulo de Security Group
│   └── secrets-manager/   # Módulo de Secrets Manager
```

---

## ⚙️ Pré-requisitos

- [Terraform >= 1.5](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI configurado
- VPC e subnets privadas já provisionadas [infra-foundation-fase4](https://github.com/FIAP-SOAT-G129/infra-foundation-fase4)
- Secrets para credenciais do banco (usuário/senha/nome do banco)

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
db_name = "fastfood_db"
db_username = "fastfood_admin"
db_password = "Fastfood-Senha#Segura$123"
```

## 🏗️ Pipeline de Automação

O projeto utiliza pipelines CI/CD no GitHub Actions para garantir a automação, qualidade e segurança do provisionamento da infraestrutura. Os principais workflows estão em `.github/workflows/`:

- **fmt-validate.yml**: Executa `terraform fmt` e `terraform validate` em todos os PRs e pushes, garantindo que o código esteja formatado e válido antes de ser aplicado.

- **plan.yml**: Gera o plano de execução do Terraform (`terraform plan`) para cada alteração, permitindo revisão prévia das mudanças que serão aplicadas na infraestrutura.

- **apply.yml**: Aplica as alterações aprovadas na infraestrutura (`terraform apply`) após revisão e aprovação do plano.

- **destroy.yml**: Automatiza a destruição dos recursos provisionados, geralmente utilizado para ambientes temporários ou de testes.
  
- **destroy-terraform.yml**: Realiza a destruição controlada dos recursos via Terraform, garantindo limpeza segura e rastreável do ambiente.

- **terraform.yml**: Workflow principal de integração contínua, podendo orquestrar validação, plano, aplicação e notificações.

### Benefícios da automação

- Reduz erros manuais e aumenta a rastreabilidade
- Garante validação e revisão antes de qualquer alteração
- Permite auditoria e histórico de mudanças
- Facilita rollback e destruição controlada de recursos

Consulte cada arquivo em `.github/workflows/` para detalhes e personalizações.
