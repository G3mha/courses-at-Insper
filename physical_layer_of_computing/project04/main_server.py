#####################################################
# Camada Física da Computação
# Enricco Gemha
# 15/09/2022
# Projeto 5
####################################################


from itertools import count
from enlace import *
from utils import *
import time
import numpy as np
from crc import CrcCalculator, Crc16

# python -m serial.tools.list_ports (communication port label)

serial_name = '/dev/ttyACM0'
msg_server = Message()
verifier = Verifier(from_server=False)
logs = Log_file('Server', 4)

def main():
    com1 = enlace(serial_name); com1.enable(); print("Abriu a comunicação")
    try:
        CRC_calculator = CrcCalculator(Crc16.CCITT)
        msg_server.set_msg_type(2)
        msg_server.set_HEAD()
        pkg_handshake_from_server = msg_server.make_pkg()

        rxBuffer, _ = com1.getData(1); com1.rx.clearBuffer(); time.sleep(.1)
        print('Limpou o buffer')

        idle = True
        while idle:
            if not(com1.rx.getIsEmpty()):
                handshake_from_client, _ = com1.getData(14)
                logs.save_log(is_envio=False, msg_type=1)
                handshake_is_correct = verifier.verify_handshake(handshake_from_client)
                if handshake_is_correct:
                    print("Handshake está correto."); idle = False
            time.sleep(1)
        com1.sendData(pkg_handshake_from_server); time.sleep(.1)
        logs.save_log(is_envio=True, msg_type=2)
        
        img_received_bin = b''
        
        counter = 1
        number_of_packages = handshake_from_client[3]
        while counter <= number_of_packages:
            timer1 = Timer(2)
            timer2 = Timer(20)
            pkg_type3 = None
            entered_1st_while = False
            while not(com1.rx.getIsEmpty()):
                entered_1st_while = True
                pkg_type3, payload_from_pkg_type3, total_size_pkg, pkg_number, checksum = get_pkg_type3(com1)
                pkg_is_type3 = verifier.verify_pkg_type3(pkg_type3)
                if not(pkg_is_type3):
                    time.sleep(1)
                    pkg_is_correct_type5 = verifier.verify_pkg_type5(pkg_type3)
                    if pkg_is_correct_type5:
                        logs.save_log(is_envio=False, msg_type=5)
                        print('Client deu timeout.'); com1.disable(); return
                if pkg_is_type3:
                    crc_check = CRC_calculator.verify_checksum(payload_from_pkg_type3, int.from_bytes(checksum, 'big'))
                    logs.save_log(is_envio=False, msg_type=3, pkg_size=total_size_pkg, pkg_number=pkg_number, amount_of_pkgs=number_of_packages, crc16=checksum)
                    eop_is_correct = verifier.verify_EOP(pkg_type3)
                    order_is_correct = (counter == pkg_type3[4])
                    if eop_is_correct and order_is_correct and crc_check:
                        print(f'Pacote {counter} recebido com sucesso')
                        msg_server.set_msg_type(4)
                        msg_server.set_last_pkg_sucesfully_received(pkg_type3[4])
                        msg_server.set_HEAD()
                        pkg_type4 = msg_server.make_pkg()
                        com1.sendData(pkg_type4); time.sleep(.1)
                        logs.save_log(is_envio=True, msg_type=4)
                        counter += 1
                        img_received_bin += payload_from_pkg_type3
                    if not(eop_is_correct) or not(order_is_correct) or not(crc_check):
                        msg_server.set_msg_type(6)
                        msg_server.set_HEAD(expected_pkg_number=counter)
                        pkg_type6 = msg_server.make_pkg()
                        com1.sendData(pkg_type6); time.sleep(.1)
                        logs.save_log(is_envio=True, msg_type=6)
                    break
            if counter == number_of_packages + 1:
                break
            while com1.rx.getIsEmpty():
                if timer2.is_timeout():
                    msg_server.set_msg_type(5)
                    msg_server.set_HEAD()
                    pkg_type5 = msg_server.make_pkg()
                    com1.sendData(pkg_type5); print("Timeout. Comunição encerrada")
                    logs.save_log(is_envio=True, msg_type=5); com1.disable(); return
                if timer1.is_timeout() and entered_1st_while:
                    msg_server.set_msg_type(4)
                    msg_server.set_last_pkg_sucesfully_received(pkg_type3[4])
                    msg_server.set_HEAD()
                    pkg_type4 = msg_server.make_pkg()
                    com1.sendData(pkg_type4); time.sleep(.1)
                    logs.save_log(is_envio=True, msg_type=4)
                    timer1.reset()


        img_received_name = 'projeto4/img/recebido.png'
        f = open(img_received_name, 'wb')
        f.write(img_received_bin)
        f.close()
        print('Arquivo recebido integralmente.\nTransmissão bem sucedida'); com1.disable()


    except Exception as erro:
        print("ops! :-\\")
        print(erro)
        com1.disable()


    #so roda o main quando for executado do terminal ... se for chamado dentro de outro modulo nao roda
if __name__ == "__main__":
    main()
