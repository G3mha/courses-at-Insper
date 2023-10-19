# Apresentação do Seminário 01

## DNS

### O que é DNS?

DNS é uma sigla para Domain Name System (em português, Sistema de Nomes de Domínios). É um sistema de gerenciamento de nomes hierárquico e distribuído operando segundo duas definições: a primeira é a de um banco de dados distribuído e hierárquico que armazena informações associadas a nomes de domínios em redes como a internet. A segunda definição é a de um protocolo de comunicação que permite a obtenção de informações de um servidor de DNS.

### Qual seu impacto na Internet?

O DNS é o responsável por localizar e traduzir para números IP os endereços dos sites que digitamos nos navegadores. Sem ele, você precisaria acessar sites apenas os endereços de IP deles, o que seria muito difícil de memorizar, e certamente impediria o crescimento da Internet como conhecemos hoje.

### Como funciona o processo de resolução?

O processo de resolução de nomes é feito em 9 etapas:

1. O cliente digita o endereço do domínio no navegador;
2. O navegador faz uma requisição HTTP para o servidor DNS recursivo. Este servidor DNS recursivo é geralmente fornecido pelo provedor de serviços de Internet (ISP) ou administrador de rede;
3. Ele consulta o próprio cache para ver se tem o registro de DNS para o domínio solicitado. Se tiver, ele responde com o registro de DNS. Se não tiver, ele faz uma requisição para o servidor DNS raiz.O servidor DNS raiz não armazena registros de DNS para domínios, mas fornece as instruções para que o seu navegador as instruções para encontrá-lo. Ele responde com o endereço IP do servidor DNS de nível superior (.com, .net, .org, etc.);
4. O navegador faz uma requisição para o servidor DNS de nível superior (TLD, Top Level Domain). Caso haja mais de um TLD, como em `.com.br`, o servidor DNS de nível superior redireciona ao servidor DNS de TDL brasileiro, neste caso. Que responde com o endereço IP do servidor DNS autoritativo para o domínio solicitado;
5. O navegador faz uma requisição para o servidor DNS autoritativo. Este servidor é responsável por armazenar os registros de DNS para o domínio solicitado;
6. Ele responde com o endereço IP do domínio solicitado;
7. O servidor DNS recursivo responde ao cliente com o endereço IP do domínio solicitado;
8. Em posse do endereço IP, o cliente faz uma requisição HTTP para o servidor web do domínio;
9. O servidor web responde com o conteúdo da página solicitada.

## NAT

### O que é NAT?

NAT é uma sigla para Network Address Translation (em português, Tradução de Endereço de Rede). É um método que permite que um roteador compartilhe um único endereço IP público entre vários dispositivos na rede local. Ele é mais comumente usado em redes domésticas, onde o roteador é usado para conectar vários computadores a uma única conexão com a Internet.

### Por que ele foi criado?

O NAT foi criado para resolver o problema da escassez de endereços IPv4. O IPv4 é um protocolo de internet que usa endereços de 32 bits. Isso significa que ele pode suportar 2^32 endereços, ou 4 bilhões de endereços. Parece muito, mas não é. A maioria dos endereços IPv4 são reservados para uso privado, como em redes domésticas e corporativas. Isso significa que os endereços IPv4 públicos são muito limitados. O NAT permite que vários dispositivos compartilhem um único endereço IPv4 público.

### Como funciona o processo de tradução?

O processo de tradução de endereços de rede é feito em 4 etapas:

1. Um dispositivo na rede interna, que possui um endereço IP privado, inicia uma comunicação com um destino na rede externa, como um servidor web na internet.
2. O roteador, que atua como uma fronteira entre a rede interna e a rede externa, traduz o endereço IP privado e a porta do dispositivo interno para um endereço IP público e uma porta específica.
3. O roteador mantém um registro da tradução na tabela de tradução NAT. Este registro inclui o endereço IP e a porta originais do dispositivo interno, o endereço IP público do roteador e a porta correspondente.
4. O roteador encaminha o pacote para o destino na rede externa usando o endereço IP público e a porta correspondente como remetente.
5. O destino externo recebe a comunicação, processa-a e envia uma resposta de volta para o endereço IP público e porta do roteador.
6. Quando a resposta chega ao roteador, ele consulta a tabela de tradução NAT para determinar a qual dispositivo interno a resposta deve ser encaminhada.
7. O roteador encaminha a resposta para o dispositivo interno com base nas informações de tradução na tabela. O dispositivo interno recebe a resposta como se estivesse se comunicando diretamente com o destino externo.
