import time
import numpy as np
from math import ceil
from datetime import datetime


class Log_file():
    def __init__(self, server_or_client, case_number):
        self.log_filename = f'projeto4/logs/{server_or_client}{case_number}.txt'
    
    def save_log(self, is_envio, msg_type, pkg_size=14, pkg_number=None, amount_of_pkgs=None):
        self.log_file = open(self.log_filename, 'a')
        now = datetime.now()
        moment_time = now.strftime("%d/%m/%Y %H:%M:%S")
        envio_or_receb = 'receb'
        if is_envio:
            envio_or_receb = 'envio'
        log_line= f'{moment_time} / {envio_or_receb} / {msg_type} / {pkg_size}'
        if msg_type == 3:
            log_line = log_line + f' / {pkg_number} / {amount_of_pkgs}'
        self.log_file.write(log_line+'\n')
        self.log_file.close()

class Message():
    def __init__(self, img=None):
        self.EOP = b'\xAA\xBB\xCC\xDD'
        self.list_payload = []
        if not(img == None):
            self.img = img
            self.make_list_payload()

    def make_list_payload(self):
        if not(self.img == None):
            img_bin = open(self.img,'rb').read()
            img_size = len(img_bin)
            pkgs = ceil(img_size/114)
            payloads = []
            for i in range(pkgs):
                if i == (pkgs-1):
                    payload = img_bin[114*i:img_size]
                    print('tamanho do ultimo payload ' , len(payload))
                else:
                    payload = img_bin[114*i:(i+1)*114]
                    print('tamanho dos payloads intermediarios : ',len(payload))
                payloads.append(payload)
            self.list_payload = payloads
            self.amount_of_pkgs = len(self.list_payload)
        

    def set_msg_type(self, msg_type):
        self.msg_type = msg_type

    def set_last_pkg_sucesfully_received(self, last_pkg_sucesfully_received):
        self.last_pkg_sucesfully_received = last_pkg_sucesfully_received

    def set_HEAD(self, current_pkg_number=1, expected_pkg_number=1):
        self.current_pkg_number = current_pkg_number
        if self.list_payload != []:
            self.current_payload_size = len(self.list_payload[self.current_pkg_number-1])

        if self.msg_type == 1: # handshake from client to server (question)
            server_ID = 4 # server ID attached to message
            list_HEAD = [self.msg_type,0,0,self.amount_of_pkgs,0,server_ID,0,0,0,0]
        
        if self.msg_type == 2: # handshake from server to client (answer)
            list_HEAD = [self.msg_type,0,0,0,0,0,0,0,0,0]

        if self.msg_type == 3: # data from client to server (payload not 0)
            list_HEAD = [self.msg_type,0,0,self.amount_of_pkgs,current_pkg_number,self.current_payload_size,0,0,0,0]

        if self.msg_type == 4: # payload check from server to client (sucessfully received)
            list_HEAD = [self.msg_type,0,0,0,0,0,0,self.last_pkg_sucesfully_received,0,0]

        if self.msg_type == 5: # timeout connection from any to other (end communication)
            list_HEAD = [self.msg_type,0,0,0,0,0,0,0,0,0]

        if self.msg_type == 6: # error on package from server to client (missing bytes or incorrect format or unexpected package)
            list_HEAD = [self.msg_type,0,0,0,0,0,expected_pkg_number,0,0,0]

        self.HEAD = bytes(list_HEAD)

    def make_pkg(self):
        payload = b''
        if self.msg_type == 3:
            payload = self.list_payload[self.current_pkg_number-1]
        pkg = self.HEAD + payload + self.EOP
        self.brute_pkg = pkg
        return np.asarray(pkg)

    def get_brute_pkg(self):
        return self.brute_pkg

    def get_amount_of_pkgs(self):
        return self.amount_of_pkgs
    
class Verifier():
    def __init__(self, from_server):
        self.from_server = from_server
        self.EOP = b'\xAA\xBB\xCC\xDD'

    def verify_handshake(self, handshake):
        if self.from_server:
            expected = 2
            received = handshake[0]
            if received == expected:
                return True
            return False

        else: # from client
            expected = [1, 4]
            received = [handshake[0], handshake[5]]
            if received == expected:
                return True
            return False
    
    def verify_EOP(self, pkg):
        if pkg[-4:] == self.EOP:
            return True
        return False

    def verify_pkg_type3(self, pkg_type3):
        expected = 3
        received = pkg_type3[0]
        if received == expected:
            return True
        return False
    
    def verify_pkg_type4(self, pkg_type4):
        expected = 4
        received = pkg_type4[0]
        if received == expected:
            return True
        return False

    def verify_pkg_type5(self, pkg_type5):
        expected = 5
        received = pkg_type5[0]
        if received == expected:
            return True
        return False

    def verify_pkg_type6(self, pkg_type6):
        expected = 6
        received = pkg_type6[0]
        if received == expected:
            return True
        return False


class Timer():
    def __init__(self, timeout):
        self.timeout = timeout
        self.start_time = time.time()

    def is_timeout(self):
        return (time.time() - self.start_time) > self.timeout

    def reset(self):
        self.start_time = time.time()


def get_pkg_type3(com1):
    HEAD_type3, _ = com1.getData(10)
    current_payload_size = int(HEAD_type3[5])
    payload_type3, _ = com1.getData(current_payload_size)
    EOP_type3, _ = com1.getData(4)
    pkg_type3 = HEAD_type3 + payload_type3 + EOP_type3
    total_size_pkg = 10 + current_payload_size + 4
    return pkg_type3, payload_type3, total_size_pkg, pkg_type3[4]
