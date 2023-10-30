# Uso da Infraestrutura

Objetivos

1. Aprender a utilizar a nuvem Openstack para aplicações mundo real;
2. Aprofundar conceitos sobre deploy de aplicações em nuvem.

Pré-requisitos:

1. Terminar o roteiro anterior (OpenStack).

## Django na Nuvem VM criada

Agora que conseguimos corrigir o erro apontado na conclusão do H2, vamos levantar a mesma aplicação Django mas sem precisar sacrificar 4 máquinas inteiras.

### Criando as instâncias necessárias

Vamos começar criando as duas instâncias de Django. Para isso, rode os comandos abaixo:

```bash
openstack server create --image jammy-amd64 --flavor m1.tiny \
   --key-name maas_key --network int_net \
    django1
```

```bash
openstack server create --image jammy-amd64 --flavor m1.tiny \
   --key-name maas_key --network int_net \
    django2
```

Em seguida, criamos a instância de banco de dados:

```bash
openstack server create --image jammy-amd64 --flavor m1.medium \
   --key-name maas_key --network int_net \
    db
```

Por fim, criamos a instância de balanceador de carga:

```bash
openstack server create --image jammy-amd64 --flavor m1.tiny \
   --key-name maas_key --network int_net \
    lb
```

### Assinalando os IPs flutuantes

Agora, vamos assinalar os IPs flutuantes para cada uma das instâncias:

```bash
IP_DJANGO1=$(openstack floating ip create -f value -c floating_ip_address ext_net)
openstack server add floating ip django1 $IP_DJANGO1
```

```bash
IP_DJANGO2=$(openstack floating ip create -f value -c floating_ip_address ext_net)
openstack server add floating ip django2 $IP_DJANGO2
```

```bash
IP_DB=$(openstack floating ip create -f value -c floating_ip_address ext_net)
openstack server add floating ip db $IP_DB
```

```bash
IP_LB=$(openstack floating ip create -f value -c floating_ip_address ext_net)
openstack server add floating ip lb $IP_LB
```

### Configurando PostgreSQL (banco de dados)

Vamos acessar a instância de banco de dados:

```bash
ssh ubuntu@$IP_DB
```

Instalando o PostgreSQL:

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

Agora, vamos criar o banco de dados e o usuário:

```bash
sudo su - postgres
createuser -s cloud -W
```

Configure a senha **cloud**. Crie a database para o projeto Django:

```bash
createdb -O cloud tasks
```

Exponha o banco de dados para acesso externo:

```bash
sudo nano /etc/postgresql/12/main/postgresql.conf
```

E dentro do arquivo, altere a linha:

```txt
    listen_addresses = '*'
```

Altere também o arquivo de configuração de autenticação:

```bash
nano /etc/postgresql/12/main/pg_hba.conf
```

E adicione a seguinte linha:

```txt
  host    all             all             172.16.0.0/20          trust
```

Saia do usuário postgres:

```bash
exit
```

Libere o firewall:

```bash
sudo ufw allow 5432/tcp
```

Por fim, reinicie o PostgreSQL:

```bash
sudo systemctl restart postgresql
```

### Configurando Django

Vamos acessar a instância de Django 1:

```bash
ssh ubuntu@$IP_DJANGO1
```

### Configurando Nginx (load balancer)

Vamos acessar a instância de balanceador de carga:

```bash
ssh ubuntu@$IP_LB
```

Instalando o Nginx:

```bash
sudo apt update
sudo apt install nginx
```

Abra o arquivo de configuração do Nginx:

```bash
sudo nano /etc/nginx/sites-available/default
```

E adicione o seguinte:

```txt
upstream backend { server backend1.example.com; server backend2.example.com; server backend3.example.com; }
server { location / { proxy_pass http://backend; } }
```

Reinicie o Nginx:

```bash
sudo service nginx restart
```
