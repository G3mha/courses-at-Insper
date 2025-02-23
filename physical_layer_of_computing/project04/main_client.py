#####################################################
# Camada Física da Computação
# Enricco Gemha
# 15/09/2022
# Projeto 5
####################################################


from types import NoneType
from enlace import *
from utils import *
import time
import numpy as np
from crc import CrcCalculator, Crc16

#   python -m serial.tools.list_ports (communication port label)

serial_name = '/dev/ttyACM1'
img = 'projeto4/img/batman.png'
msg_client = Message(img)
verifier = Verifier(from_server=True)
logs = Log_file('Client', 4)


def main():
    com1 = enlace(serial_name); com1.enable(); print("Abriu a comunicação")
    try:
        CRC_calculator = CrcCalculator(Crc16.CCITT)
        msg_client.set_msg_type(1)
        msg_client.set_HEAD()
        pkg_handshake_from_client = msg_client.make_pkg()


        begin = False
        com1.sendData(b'00'); time.sleep(.1) # sacrifice bit
        while not(begin):
            com1.rx.clearBuffer()

            com1.sendData(pkg_handshake_from_client); time.sleep(.1) # handshake
            logs.save_log(is_envio=True, msg_type=1)
            time.sleep(5)

            if com1.rx.getIsEmpty():
                continue

            handshake_from_server, _ = com1.getData(14)
            logs.save_log(is_envio=False, msg_type=2)
            handshake_is_correct = verifier.verify_handshake(handshake_from_server)
            if handshake_is_correct:
                print("Handshake está correto."); begin = True

        # list_pairs = []
        # for i in range(0,126):
        #     if i%2 == 0:
        #         list_pairs.append(i)

        number_of_packages = msg_client.get_amount_of_pkgs()
        counter = 1
        while counter <= number_of_packages:
            entered_1st_while = False
            msg_client.set_msg_type(3)
            msg_client.set_HEAD(current_pkg_number=counter)
            # if counter in list_pairs:
            #     msg_client.set_HEAD(current_pkg_number=1); list_pairs.remove(counter)
            pkg_type3 = msg_client.make_pkg()
            com1.sendData(pkg_type3); time.sleep(.1)
            brute_pkg = msg_client.get_brute_pkg()
            logs.save_log(is_envio=True, msg_type=3, pkg_size=(brute_pkg[5]+14), pkg_number=(brute_pkg[4]), amount_of_pkgs=number_of_packages)
            timer1 = Timer(5)
            timer2 = Timer(20)
            pkg_type4_5_or_6 = None
            waiting_for_resend = False
            while not(com1.rx.getIsEmpty()):
                entered_1st_while = True
                pkg_type4_5_or_6, _ = com1.getData(14)
                pkg_is_correct_type4 = verifier.verify_pkg_type4(pkg_type4_5_or_6)
                pkg_is_correct_type5 = verifier.verify_pkg_type5(pkg_type4_5_or_6)
                pkg_is_correct_type6 = verifier.verify_pkg_type5(pkg_type4_5_or_6)
                if pkg_is_correct_type4:
                    if pkg_type4_5_or_6[7] != counter:
                        counter = pkg_type4_5_or_6[7] - 1
                    counter += 1
                    logs.save_log(is_envio=False, msg_type=4)
                    print(f'Pacote {counter} enviado com sucesso')
                    break
                if pkg_is_correct_type5 and not(pkg_is_correct_type4) and not(pkg_is_correct_type6):
                    logs.save_log(is_envio=False, msg_type=5)
                    print('Server deu timeout.'); com1.disable(); return
                if pkg_is_correct_type6 and not(pkg_is_correct_type5) and not(pkg_is_correct_type4):
                    logs.save_log(is_envio=False, msg_type=6)
                    counter = pkg_type4_5_or_6[6]
                    msg_client.set_msg_type(3)
                    msg_client.set_HEAD(current_pkg_number=counter)
                    pkg_type3 = msg_client.make_pkg()
                    com1.sendData(pkg_type3); time.sleep(.1)
                    brute_pkg = msg_client.get_brute_pkg()
                    logs.save_log(is_envio=True, msg_type=3, pkg_size=(brute_pkg[5]+14), pkg_number=(brute_pkg[4]), amount_of_pkgs=number_of_packages)
                    timer1.reset()
                    timer2.reset()
            if counter == number_of_packages + 1:
                break
            while com1.rx.getIsEmpty():
                if timer1.is_timeout() and entered_1st_while:
                    com1.sendData(pkg_type3); time.sleep(.1)
                    brute_pkg = msg_client.get_brute_pkg()
                    logs.save_log(is_envio=True, msg_type=3, pkg_size=(brute_pkg[5]+14), pkg_number=(brute_pkg[4]), amount_of_pkgs=number_of_packages)
                    timer1.reset()
                if timer2.is_timeout():
                    msg_client.set_msg_type(5)
                    msg_client.set_HEAD()
                    pkg_type5 = msg_client.make_pkg()
                    com1.sendData(pkg_type5); print("Timeout. Comunição encerrada")
                    logs.save_log(is_envio=True, msg_type=5); com1.disable(); return


        print('Transmissão bem sucedida'); com1.disable()

    except Exception as erro:
        print("ops! :-\\")
        print(erro)
        com1.disable()
        

    #so roda o main quando for executado do terminal ... se for chamado dentro de outro modulo nao roda
if __name__ == "__main__":
    main()
