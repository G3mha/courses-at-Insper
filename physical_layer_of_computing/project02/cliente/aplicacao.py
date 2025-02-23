#####################################################
# Camada Física da Computação
#Carareto
#11/08/2022
#Aplicação
####################################################


#esta é a camada superior, de aplicação do seu software de comunicação serial UART.
#para acompanhar a execução e identificar erros, construa prints ao longo do código! 


from email.mime import image
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
serialName = "COM8"                  # Windows(variacao de)


def main():
    try:
        lista_de_possiveis_comandos = [b'\x00\xFA\x00\x00',b'\x00\x00\xFA\x00',b'\xFA\x00\x00',b'\x00\xFA\x00',b'\x00\x00\xFA',b'\x00\xFA',b'\xFA\x00',b'\x00', b'\xFA' ]
        print("Iniciou o main")

        numero_de_comandos = np.random.randint(10,30)

        # print('numero de comandos a ser enviado é : {}'.format(numero_de_comandos))
        #declaramos um objeto do tipo enlac e com o nome "com". Essa é a camada inferior à aplicação. Observe que um parametro
        #para declarar esse objeto é o nome da porta.
        com1 = enlace(serialName)
        
    
        # Ativa comunicacao. Inicia os threads e a comunicação seiral 
        com1.enable()

        time.sleep(.2)
        com1.sendData(b'00')
        time.sleep(1)

        #Se chegamos até aqui, a comunicação foi aberta com sucesso. Faça um print para informar.
        print("Abriu a comunicação")
        print("Enviando número de comandos :")
        txBuffer = bytes([numero_de_comandos])
        com1.sendData(np.asarray(txBuffer))
        print(f'numeri de comandos será: {numero_de_comandos}')

        # txBuffer = bytes([3])
        # com1.sendData(np.asarray(txBuffer))
        # print(f'numeri de comandos será: {3}')

        
           
        #Sorteando e enviado os comandos
        print('Irá começar a transmissão')
        for i in range(numero_de_comandos):
            # print('entrou aqui')
            indice_da_lista = np.random.randint(0,8)
            item_da_lista = lista_de_possiveis_comandos[indice_da_lista]
            tamanho = len(item_da_lista)
            enviar = bytes([tamanho])
            print('enviado tamanho', np.asarray(enviar))
            
            com1.sendData(np.asarray(enviar))
            
            time.sleep(1)
            com1.sendData(np.asarray(item_da_lista))
            print('mostrando o byte enviado ' ,item_da_lista)
            time.sleep(1)

            # print(i)
        # binario = b'\xAA'

        # print("meu array de bytes tem tamanho {}" .format(len(binario)))

        # tamanho_5 = b'\x05'
        # com1.sendData(np.asarray(tamanho_5))
        # time.sleep(1)
        # binFinal = b'\x00\xFA\x00\x00\xFA'
        # com1.sendData(np.asarray(binFinal))
        
        # com1.sendData(np.asarray(binario))  #as array apenas como boa pratica para casos de ter uma outra forma de dados
          
  
        

            
    
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
