# Documentação Técnica do projeto `SimplePythonCRUD`

## Introdução

Projeto desenvolvido por **Enricco Gemha** para a disciplina de **Computação em Nuvem** do curso de **Engenharia de Computação** do **Insper Instituto de Ensino e Pesquisa**.

Dado a especificação do projeto, foi desenvolvido um CRUD simples em Python utilizando os frameworks FastAPI e SQLAlchemy, e o banco de dados MySQL.

A aplicação foi hospedada na Amazon Web Services (AWS), sendo possível criar toda a infraestrutura necessária para a aplicação utilizando somente o script Terraform disponível neste repositório, bem como destruí-la completamente.

## Utilização do script Terraform

Para começar, é necessário ter uma conta na AWS e obter seu `access_key_id` e `secret_access_key`.

O próximo passo é instalar o AWS CLI, e configurar as credenciais de acesso no seu computador, para isso siga as instruções disponíveis [aqui](https://docs.aws.amazon.com/pt_br/rekognition/latest/dg/setup-awscli-sdk.html).

Em seguida, é necessário instalar o Terraform, para isso siga as instruções disponíveis [aqui](https://developer.hashicorp.com/terraform/install).

E configure o arquivo `terraform.tfvars` no `<path_to_this_project>/terraform` com as informações necessárias para a criação da infraestrutura. O arquivo deve ter o seguinte formato:

```terraform
db_username = "<usuário>"
db_password = "<senha>"
```

**Assumindo que você esteja na raíz do repositório**, execute os seguintes comandos:

```bash
cd terraform/bucket
terraform init
terraform validate
terraform plan -out="tfplan"
terraform apply "tfplan"
```

```bash
cd ..
terraform init
terraform validate
terraform plan -out="tfplan"
terraform apply "tfplan"
```

## Diagrama de infraestrutura

![Diagrama de infraestrutura](./docs/diagram.png)

## Decisões técnicas

- Para a aplicação, configurada em Ubuntu, foi utilizado Elastic Compute Cloud (EC2);
- Para banco de dados, foi hospedado no Relational Database Service (RDS);
- Para a comunicação entre os serviços, foi utilizado o serviço de Virtual Private Cloud (VPC);
- Para monitoramento de utilização, foram implementadas métricas e políticas utilizando o serviço de CloudWatch;
- Para balanceamento de carga, foi utilizado o serviço de Application Load Balancer (ALB);
- Para garantir a proteção da comunicação entre os serviços, foram criados _firewalls_, utilizando o serviço de Security Groups.
- Para garantir o redirecionamento para somente instância saudáveis, foram implementados Health Checks para o ALB;
- Para garantir a alta disponibilidade, foram criadas duas instâncias EC2 padrão, escaláveis até seis, através de uma Auto Scaling Group (ASG);
- Para garantir que não haja concorrência nas operações do Terraform, foi utilizado o serviço de Locking do DynamoDB, com armazenamento de estado no S3, garantindo o versionamento do código;
- Para garantir a segurança das instâncias, foi criado um IAM Role, com somente as permissões necessárias para a execução do script de instalação e configuração da aplicação;

## Custos de manutenção

## Referências
