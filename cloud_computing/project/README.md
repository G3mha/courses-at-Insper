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

Neste diagrama, cada cor representa uma camada de abstração da infraestrutura, sendo `preto` a cor referente a camada de serviços AWS, ou seja, a camada de "cloud", em `roxo` a camada de rede, como o IPRouter e a VPC, em `vermelho` as camadas de segurança, representadas pelos Security Groups, em `verde` as camadas de subnets, pública e privada, em `azul` a camada de monitoramento, representada pelo CloudWatch, e em `laranja` a camada de aplicação, representada pelas instâncias EC2, o ALB e o banco de dados RDS, bem como a própria aplicação CRUD que é visível ao usuário. A World Wide Web é representada por um círculo em `azul`. As setas representam a comunicação entre os serviços.

## Decisões técnicas

- Para a aplicação, configurada em Ubuntu, foi utilizado Elastic Compute Cloud (EC2);
- Para banco de dados, foi hospedado no Relational Database Service (RDS);
- Para a comunicação entre os serviços, foi utilizado o serviço de Virtual Private Cloud (VPC);
- Para monitoramento de utilização, foram implementadas métricas e políticas utilizando o serviço de CloudWatch;
- Para balanceamento de carga, foi utilizado o serviço de Application Load Balancer (ALB);
- Para garantir a proteção da comunicação entre os serviços, foram criados _firewalls_, utilizando o serviço de Security Groups;
- Para garantir o redirecionamento para somente instância saudáveis, foram implementados Health Checks para o ALB;
- Para garantir a alta disponibilidade, foram criadas duas instâncias EC2 padrão, escaláveis até seis, através de uma Auto Scaling Group (ASG);
- Para garantir que não haja concorrência nas operações do Terraform, foi utilizado o serviço de Locking do DynamoDB, com armazenamento de estado no S3, garantindo o versionamento do código;
- Para garantir a segurança das instâncias, foi criado um IAM Role, com somente as permissões necessárias para a execução do script de instalação e configuração da aplicação.

### A escolha de região

Com regiões de disponilibidade em todo o mundo, vem também a necessidade de escolher uma região com requisitos que favoreça o desempenho e custo da aplicação. Esses benefícios são obtidos através de requisitos de:

- **Velocidade de Conexão** (Latência):
  - Por ser uma aplicação web que não será consumida como produto final, a latência é um fator opcional, pois não é um fator que influencia diretamente na experiência do usuário. Por isso **não foi um fator decisivo na escolha** da região;

- **Velocidade de Processamento**:
  - Devido aos dados a serem processados serem pequenos e simples, a velocidade de processamento não impacta de forma relevante na aplicação, portanto **não foi um fator decisivo na escolha** da região;

- Disponibilidade de Serviços:
  - A AWS possui uma grande variedade de serviços, e a maioria deles está disponível em todas as regiões, contudo existem restrições. Por exemplo, o `t2.micro`, escolhida por ser a opção _low-cost_ e _general purpose_ da AWS, está [disponível somente em](https://aws.amazon.com/pt/about-aws/whats-new/2014/07/01/introducing-t2-the-new-low-cost-general-purpose-instance-type-for-amazon-ec2/):
    - `us-east-1` (N. Virginia);
    - `us-west-2` (Oregon);
    - `eu-west-1` (Ireland);
    - `ap-northeast-1` (Tokyo);
    - `ap-southeast-1` (Singapore);
    - `ap-southeast-2` (Sydney);
    - `sa-east-1` (São Paulo);
  - Há também a necessidade de se descartar as regiões com outages mais frequentes, e como podemos ver nesta [_thread_ da YCombinator](https://news.ycombinator.com/item?id=13756082) (Aceleradora de Startups de Silicon Valley), a região `us-east-1` (N. Virginia) é explicitamente não recomendada, pois possui um histórico de outages mais frequentes, bem como equipamento ultrapassado. Ainda no mesmo tópico, o site [AWSManiac](https://awsmaniac.com/aws-outages/) menciona as seguintes regiões como as de maior quantidade de outages da história da AWS, nesta ordem:
    - `us-east-1` (N. Virginia);
    - `ap-southeast-2` (Sydney);
    - `ap-northest-1` (Tokyo);
  - O site [StatusGator](https://statusgator.com/blog/is-north-virginia-aws-region-the-least-reliable-and-why/) oferece uma lista com as regiões com maior tempo de downtimes parcias em 2022, sendo, nesta ordem, as três piores:
    - `us-east-1` (N. Virginia);
    - `us-west-2` (Oregon);
    - `us-east-2` (Ohio);

- Custo de Serviços:
  - O custo de serviços é um fator importante em qualquer aplicação, e como o objetivo deste projeto é criar uma aplicação de baixo custo, é necessário escolher uma região que ofereça os serviços necessários com o menor custo possível. Os dados são o site [ConcurrencyLabs](https://www.concurrencylabs.com/blog/choose-your-aws-region-wisely/), com dados extraídos da AWS PriceList API. Portanto, da lista da `t2.micro` acima, podemos observar os seguintes preços (porcentagem de diferença em relação a `us-east-1`, a mais barata):
    - [0%] `us-east-1` (N. Virginia);
    - [0%] `us-west-2` (Oregon);
    - [11%] `eu-west-1` (Ireland);
    - [22%] `ap-northeast-1` (Tokyo);
    - [14%] `ap-southeast-1` (Singapore);
    - [26%] `ap-southeast-2` (Sydney);
    - [52%] `sa-east-1` (São Paulo);

Baseado nesses requisitos, excluímos todas as regiões que não possuem `t2.micro`. Em seguida, excluímos a região `us-east-1` (N. Virginia) pela imensa quantidade de outages. Excluímos `ap-southeast-2` (Sydney), `ap-northeast-1` (Tokyo) e `sa-east-1` (São Paulo) por possuírem uma grande diferença de custo em relação a `us-east-1` (N. Virginia). E por fim, excluímos `us-west-2` (Oregon) por possuir um histórico de outages, apesar de ser a segunda região mais barata. Com isso, ficamos em um empate entre `eu-west-1` (Ireland) e `ap-southeast-1` (Singapore), e como a região `eu-west-1` (Ireland) possui um custo 11% menor, foi a escolhida para hospedar a aplicação.

## Custos de manutenção mensal

Para realizar uma estimativa de custos, foi utilizado o [AWS Pricing Calculator](https://calculator.aws/#/). Os custos foram estimados para um período de 1 mês, e os valores foram convertidos para Reais utilizando a cotação do dólar do dia 03/12/2023, de R$4,92, de acordo com o [Banco Central do Brasil](https://www.bcb.gov.br/conversao).

### Amazon Virtual Private Cloud (VPC)

Parâmetros:

- Região: `eu-west-1` (Ireland);
- VPC services: `Data Transfer`;
- Number of VPN Connections: `1`;
- Data Transfer Intra-region (GB): `1`;
- Data Transfer All other regions (GB): `1`.
- Data Transfer Out to Internet (GB): `1`;

### Amazon RDS for MySQL

Parâmetros:

- Região: `eu-west-1` (Ireland);
- Quantidade de instâncias: `1`;
- Tipo de instância: `db.t2.micro`;
- Utilização: `On-Demand (100%)`;
- Deployment options: `Multi-AZ`;
- Storage: `General Purpose SSD (gp2)`;
- Storage (GB): `20`.

### Amazon EC2

Parâmetros:

- Região: `eu-west-1` (Ireland);
- Tipo de instância: `t2.micro`;
- Tenancy: `Shared`;
- Operating System: `Linux`;
- Workloads: `Daily spike traffic`;
- Workload (days): `Monday to Friday`;
- Baseline (instances): `2`;
- Peak (instances): `6`;
- Duration of peak (hours): `6`;
- Payment option: `EC2 Instance Savings Plans (1 Year, No Upfront)`.

### Elastic Load Balancing

Parâmetros:

- Região: `eu-west-1` (Ireland);
- Tipo de load balancer: `Application Load Balancer`;
- Features: `Load Balancer on Outposts`;
- Número de ALBs: `1`.

### Amazon Simple Storage Service (S3)

Parâmetros:

- Região: `eu-west-1` (Ireland);
- S3 Storage Class: `Standard`;
- Storage (GB): `0.01`;
- Requests: `10`;
- Data Returned by S3 Select (GB): `0.001`.
- Data Scanned by S3 Select (GB): `0.01`.

### Amazon DynamoDB

Parâmetros:

- Região: `eu-west-1` (Ireland);
- Features: `DynamoDB Data Import from Amazon S3 feature`;
- Source file size (GB): `0.01`;

### Amazon API Gateway

Parâmetros:

- Região: `eu-west-1` (Ireland);
- API Type: `REST API`;
- Request units: `millions`;
- Requests per month: `1`;

### Amazon CloudWatch

Parâmetros:

- Região: `eu-west-1` (Ireland);
- Number of metrics: `2`;
- Number of Standard Resolution Alarm Metrics: `2`;
