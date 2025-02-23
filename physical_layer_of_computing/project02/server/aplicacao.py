#####################################################
# Camada Física da Computação
#Carareto
#11/08/2022
#Aplicação
####################################################


#esta é a camada superior, de aplicação do seu software de comunicação serial UART.
#para acompanhar a execução e identificar erros, construa prints ao longo do código! 


from email.mime import image        
from re import A
from enlace import *
import time
import numpy as np

# voce deverá descomentar e configurar a porta com através da qual ira fazer comunicaçao
#   para saber a sua porta, execute no terminal :
#   python -m serial.tools.list_ports
# se estiver usando windows, o gerenciador de dispositivos informa a porta

#use uma das 3 opcoes para atribuir à variável a porta usada
#serialName = "/dev/ttyACM0"           # Ubuntu (variacao de)
#serialName = "/dev/tty.usbmodem1411" # Mac    (variacao de)
serialName = "COM9"                  # Windows(variacao de)


def main():
    try:
        timeout = 5

        print("Iniciou o main")
        #declaramos um objeto do tipo enlace com o nome "com". Essa é a camada inferior à aplicação. Observe que um parametro
        #para declarar esse objeto é o nome da porta.

        com1 = enlace(serialName)
        
        # Ativa comunicacao. Inicia os threads e a comunicação seiral 
        
        com1.enable()

        #Se chegamos até aqui, a comunicação foi aberta com sucesso. Faça um print para informar.
        
        print("Abriu a comunicação")
        
        print("esperando 1 byte de sacrifício")
        rxBuffer, nRx = com1.getData(1)
        print(rxBuffer)
        com1.rx.clearBuffer()
        print('limpou')
        time.sleep(.1)
                  

        
        #Bity após o de sacrifício seria o número de comandos q ele vai receber
        rxBuffer, nRx = com1.getData(1)
        numero_de_comandos = int.from_bytes(rxBuffer, byteorder='little')
        print(numero_de_comandos)
        time.sleep(.1)
        #depois começar a rotina de recebimento de bytes e começar a contagem
        #Lembrar de colocar a condição de timeout
        #Printar número de comandos recebidos

        recebidos = 0
        # rxBuffer, nRx = com1.getData(5)
        verificando_timeout = float(time.time())
        print(verificando_timeout)
        deu_timeout = float(time.time() - verificando_timeout) 
        print(deu_timeout)
        
        def atualiza_tempo(tempo_ref):
            tempo_atual = float(time.time())
            referencia = float(tempo_atual-tempo_ref)
            # print(referencia)
            return referencia   

        while (recebidos < numero_de_comandos) and (deu_timeout <= timeout):
            print('Recebendo o tamanho')
            rxBuffer, nRx = com1.getData(1)
            time.sleep(.1)  
            esperado =  int.from_bytes(rxBuffer,byteorder='little')
            time.sleep(.4)  
            print('esse é  byte esperado tamanho: ', esperado)
            time.sleep(.1)  
            rxBuffer, nRx = com1.getData(esperado)
            print('recebido: {}'.format(rxBuffer))
            # print(nRx)
            time.sleep(.1)  
            recebidos+=1
            deu_timeout = atualiza_tempo(verificando_timeout)
            verificando_timeout = float (time.time())

        if deu_timeout >= timeout:
            print('time out')

        # print('esperando 1 byte teste')
        else:
            print('')
            print(f'o número de comandos recebidos foi: {recebidos}')
            print('')
        # Encerra comunicação
        print("-------------------------")
        print("Comunicação encerrada")
        print("-------------------------")
        com1.disable()
        
    except Exception as erro:
        print("ops! :-\\")
        print(erro)
        com1.disable()
        

    #so roda o main quando for executado do terminal ... se for chamado dentro de outro modulo nao roda
if __name__ == "__main__":
    main()
