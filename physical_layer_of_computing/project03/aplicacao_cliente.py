#####################################################
# Camada Física da Computação
#Carareto
#11/08/2022
#Aplicação
####################################################


#esta é a camada superior, de aplicação do seu software de comunicação serial UART.
#para acompanhar a execução e identificar erros, construa prints ao longo do código! 


from timeit import repeat
from enlace import *
import time
import numpy as np
from utils import *

# voce deverá descomentar e configurar a porta com através da qual ira fazer comunicaçao
#   para saber a sua porta, execute no terminal :
#   python -m serial.tools.list_ports
# se estiver usando windows, o gerenciador de dispositivos informa a porta

#use uma das 3 opcoes para atribuir à variável a porta usada
serialName = "/dev/ttyACM1"           # Ubuntu (variacao de)
#serialName = "/dev/tty.usbmodem1411" # Mac    (variacao de)
# serialName = "COM10"                  # Windows(variacao de)


# HEAD - serviria para passar informações da "mensagem" que está chegando, protocolo. Escreve os metadados
"""
    Informações que vão estar no 10Bytes do Head

    1 - [mensagem,erro, img, conectar] Pergunta ?
    2 -  Resposta Principal  Verificação do HandShake
    3 - Número de Bytes do PayLoad

    4 - Número do Pacote
    5 - Número total de pacotes
    6 -  Dizer que a transmissão foi um sucesso

    7 -  placeHolder
    8 -  placeHolder
    9 - placeHolder
    10 -  placeHolder 
"""

# Payload - dados principais que serão enviados


#EOP - Sinal de finalização do datagrama
"""

    Bytes do datagrama

    1 - \xAA
    2 - \xAA
    3 - \xAA 
    4 - \xAA 

"""


# ======== TASK =======
"""
    1 - Funcão para verificar o HandShake ENRICCO
    4- Função que verifica se o EOP está no local correto (4 últimos bytes) ENRICCO
    5- Função que reagrupa os bytes e devolve para o cliente que a transmissão foi um sucesso LINK
    2 - Função para montar o Payload LINK ------------------
    3- Função que verifica se a ordem está correta LINK ------------------

"""


def main():
    try:
        print("Iniciou o main")
        com1 = enlace(serialName); com1.enable()
        
        print("Abriu a comunicação")
        img = 'projeto3/img/Capturar2.PNG'; img_bin = open(img,'rb').read()
        payloads_list = monta_payload(img_bin) # Lista com a imagem divida em varios payloads
        HEAD_handshake = bytes([4,0,0,0,len(payloads_list),0,0,0,0,0])
        handshake_client = np.asarray(HEAD_handshake+EOP)


        com1.sendData(b'00'); time.sleep(.1) # bit de sacrificio
        com1.sendData(handshake_client); time.sleep(.1)


        try_connection = 'S'

        while True:
            com1.rx.clearBuffer()
            timer = time.time()
            while com1.rx.getIsEmpty() and (atualiza_tempo(timer) < 5):
                pass
            if com1.rx.getIsEmpty():
                try_connection = str(input('Servidor inativo. Tentar novamente? S/N: '))
                if try_connection == 'S':
                    com1.sendData(b'00'); time.sleep(.1) # bit de sacrificio
                    com1.sendData(handshake_client); time.sleep(.1)
                if try_connection == 'N':
                    print('Servidor inativo. Tente novamente mais tarde.'); com1.disable(); return
            else:
                handshake_server, _ = com1.getData(14)
                is_handshake_correct = verifica_handshake(handshake_server, True)
                if not is_handshake_correct:
                    print('Handshake diferente do esperado. Tente novamente mais tarde.'); com1.disable(); return
                if is_handshake_correct:
                    print("Handshake vindo do server está correto."); break


        current_package = 1
        for payload in payloads_list:
            HEAD_content_client = bytes([3,0,len(payload),current_package,len(payloads_list),0,0,0,0,0]) 
            package = HEAD_content_client + payload + EOP
            com1.sendData(np.asarray(package))
            current_package += 1
            
            feedback_to_client, _ = com1.getData(1); time.sleep(.1)
            if feedback_to_client == 6:
                print(f'Tamanho do payload incorreto no pacote {current_package}. Reenvie o pacote.'); com1.disable(); return
                # implementar no proximo projeto
            if feedback_to_client == 7:
                print(f'Pacote {current_package} enviado com sucesso.')
            com1.rx.clearBuffer(); time.sleep(.1)

        HEAD_final_server, _ = com1.getData(10) # Recebendo o HEAD do server
        is_transmission_correct = (HEAD_final_server[5] == 1)
        EOP_final_server, _ = com1.getData(4) # Recebendo o EOP do server
        package_final_server = HEAD_final_server + EOP_final_server
        is_eop_correct = verifica_eop(package_final_server, HEAD_final_server)

        if not is_transmission_correct:
            print('Erro no envio dos pacotes. Tente novamente.')
        if is_transmission_correct and is_eop_correct:
            print('Transmissão bem sucedida')
    
        print("-------------------------\nComunicação encerrada\n-------------------------"); com1.disable()
        
    except Exception as erro:
        print("ops! :-\\")
        print(erro)
        com1.disable()
        

    #so roda o main quando for executado do terminal ... se for chamado dentro de outro modulo nao roda
if __name__ == "__main__":
    main()
