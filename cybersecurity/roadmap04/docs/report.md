# Roteiro 4 - Integração com Telegram e CloudWatch

## Cyber Segurança em Nuvem 2024.1

### Grupo: Antônio Martins, Ariel Leventhal e Enricco Gemha

## Introdução

Este roteiro tem como objetivo melhorar as medidas de segurança do ambiente nuvem da ABCPLACE, através da utilização de ferramentas como o Zabbix e Wazuh, que irão ser integrados com o Telegram, para envio de alertas, e com o CloudWatch, para monitoramento de logs.

## 1. Integração com Telegram

### 1.0 Criação de Bot no Telegram

Para a integração do Zabbix com o Telegram, é necessário criar um bot no Telegram, utilizando o serviços do BotFather, que irá fornecer um token de acesso para o bot.

Com o bot criado, o mesmo deverá ser adicionado a um grupo de Telegram com os Administradores do Sistema, neste caso, os integrantes do grupo.

![BotFather](./imgs/telegram-group-information.png)

### 1.1 Configuração do Zabbix

#### 1.1.0 Criação de Media Types

Para a integração do Zabbix com o Telegram, é necessário criar um novo tipo de mídia, que irá permitir o envio de mensagens para o Telegram.

![Zabbix Media Types](./imgs/zabbix-media-type.png)

É importante destacar que o Token utilizado é o mesmo token recebido pelo BotFather, e o `To` é referente ao identificador único do grupo de Telegram.

Para verificar se a integração foi feita corretamente, é possível enviar uma mensagem de teste.

![Zabbix Telegram Test Message](./imgs/telegram-zabbix-test.png)

#### 1.1.1 Adição de Media em Usuário Administrador

Será configurado no usuário administrador do Zabbix a nova mídia criada.

![Zabbix Users](./imgs/zabbix-users.png)

![Zabbix User Media](./imgs/zabbix-admin-media.png)

![Zabbix User Media Add](./imgs/zabbix-user-media.png)

#### 1.1.2 Zabbix Actions

Para que o Zabbix envie mensagens para o Telegram, é necessário criar uma nova ação, que irá ser acionada quando um alerta for disparado.

![Zabbix Actions](./imgs/zabbix-actions.png)

![Zabbix Action Operators](./imgs/zabbix-actions-operations.png)

### 1.1.3 Teste de Integração com Telegram

Para testar a integração com Telegram, serão deslizadas a máquina do MySql, que irá disparar um alerta no Zabbix.

![Zabbix Alert](./imgs/zabbix-test.png)

Com isso é possível verificar que os alertas estão funcionando, no decorrer desta atividade, foram feitos outros testes, com outras instâncias, o que gerou outros alertas:

![Zabbix Alert 2](./imgs/zabbix-telegram-other.png)

## 2. Integração com CloudWatch

### 2.1 Configuração do CloudWatch para o Wazuh

Conforme solicitado, instalou-se e configurou-se os agentes do CloudWatch para enviar logs das instâncias ao serviço titular. Verifica-se isto nas screenshots a seguir:

![2.1.1](./imgs/2.1.1.png)

![2.1.2](./imgs/2.1.2.png)

### 2.2 IAM para o CloudWatch

Concedeu-se permissão ao user group `abc-place` para acessar todos os logs do CloudWatch, como visto na imagem abaixo.

![2.2](./imgs/2.2.png)

### 2.3 Métricas e filtros no CloudWatch para tentativas de autenticação SSH (sucesso ou falha)

Comecou criando-se o log group `auth-logs`, que recebe os logs vindos de todos os agentes do CloudWatch.

![2.3.0](./imgs/2.3.0.png)

Criaram-se duas métricas associadas a `auth-logs`. Um deles reconhece padrões de logins SSH bem-sucedidos nos logs, enquanto o outro reconhece tentativas falhas.

![2.3.1](./imgs/2.3.1.png)

### 2.4 Alarme no CloudWatch para tentativas de autenticação SSH

Definiu-se um tópico SNS (Simple Notification Service), atrelado a *cbsec10@gmail.com*, que fará a notificação via e-mail dos alarmes, como se atesta abaixo:

![2.4.0](./imgs/2.4.0.png)

Em seguida, configuram-se propriamente os alarmes, um disparando após 3 tentativas falhas dentro de uma janela de 5 minutos, e outro a cada 1 tentativa bem-sucedida de autenticação.

![2.4.1](./imgs/2.4.1.png)

![2.4.2](./imgs/2.4.2.png)

![2.4.3](./imgs/2.4.3.png)

Com isso, pode-se observar nos gráficos o fluxo de tentativas, bem e mal-sucedidas.

![2.4.4](./imgs/2.4.4.png)

![2.4.5](./imgs/2.4.5.png)

Por fim, confirmou-se o funcionamento do serviço de notificação via e-mail, para ambos os casos, como é mostrado abaixo:

![2.4.6](./imgs/2.4.6.png)

![2.4.7](./imgs/2.4.7.png)

## 3. Integração do Zabbix com Email

### 3.0 Configuração do Servidor SMTP

Para a integração com o servidor SMTP, foi utilizado o serviço da A2C Solutions, hospedado no endereço `mail.a2csolutions.com.br`, com a porta `465` para envio de mensagens.

### 3.1 Configuração de Media Type

Foi criada um Media Type específico para envio de mensagens por email, com as configurações do servidor SMTP, e o email de destino, com o nome `cbsecsmtp`.

![Email Media Type](./imgs/zabbix-email-media-type.png)

![Email Templates](./imgs/email-templates.png)


### 3.2 Configuração de Usuário

Como descrito nos passos da atividade, há a necessidade de se criar um usuário apenas para o envio de email. 

![Email User](./imgs/email-user.png)

Para este usuário conseguir realizar o envio de emails e ter acesso a actions, há a necessidade de dar a ele permissões de superadmin, e alterar sua Media.

![User Media](./imgs/email-user-media.png)

![User Permissions](./imgs/user-permitions.png)

### 3.3 Configuração de Ação

Para que o Zabbix envie emails, é necessário criar uma nova ação, que irá ser acionada quando um alerta for disparado.

![Zabbix Email Action](./imgs/zabbix-action-email.png)