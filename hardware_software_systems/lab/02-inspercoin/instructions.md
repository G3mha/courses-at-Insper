# inspercoin

Inspercoin - Repositório Exemplo para Lab de Processos

## Instalação

Vamos instalar as bibliotecas necessárias para criptografia e para trabalhar com json.

```
sudo apt update
sudo apt install libsodium-dev
sudo apt install libcurl4-openssl-dev
sudo apt install libjansson-dev
```

## Compilar
```
make rebuild
```

## Exemplos de execução

```
./inspercoin criar carteira vida_boa
./inspercoin enviar 0.01 da carteira vida_boa para endereco E9AE8BF0871DB8F50E58DEF4C2D230B31B72155D97978A486FC6469053BAD23A com recompensa 0.001
```

