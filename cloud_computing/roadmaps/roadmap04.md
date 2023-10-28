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
openstack server create --image jammy-amd64 --flavor m1.tiny \
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

### Configurando Nginx (load balancer)

### Configurando PostgreSQL (banco de dados)

### Configurando Django
