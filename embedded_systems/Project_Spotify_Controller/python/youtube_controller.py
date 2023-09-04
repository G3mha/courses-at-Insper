import pyautogui
import serial
import argparse
import time
import logging
from ctypes import cast, POINTER
from comtypes import CLSCTX_ALL
from pycaw.pycaw import AudioUtilities, IAudioEndpointVolume


class MyControllerMap:
    def __init__(self):
        self.button = {} # Fast forward (10 seg) pro Youtube

class SerialControllerInterface:
    # ProtocoloT
    # byte 1 -> Botão 1 (estado - Apertado 1 ou não 0)
    # byte 2 -> EOP - End of Packet -> valor reservado 'X'

    def __init__(self, port, baudrate):
        self.ser = serial.Serial(port, baudrate=baudrate)
        self.mapping = MyControllerMap()
        self.incoming = '0'
        pyautogui.PAUSE = 0  ## remove delay
    def update(self):
        try:
            ## Sync 
            while self.incoming != b'X':
                self.incoming = self.ser.read()
                logging.debug("Received INCOMING: {}".format(self.incoming))

            data = self.ser.read()
            value1 = self.ser.read()
            value2 = self.ser.read()
            
            valor = int.from_bytes(value2 + value1, 'big')
            print(valor)
            if data == b'h':
                self.ser.write(b'h')
            if data == b'b':
                logging.debug("Received DATA: {}".format(data))
                logging.info(f"KEYDOWN {valor}")
                if valor  == 1:
                    pyautogui.hotkey('ctrl', 'LEFT')
                elif valor ==2:
                    pyautogui.press('space')
                elif valor ==3:
                    pyautogui.hotkey('ctrl', 'RIGHT')
            
            if data == b'a':
                logging.info(f"Analogico: {valor}")
                devices = AudioUtilities.GetSpeakers()
                interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
                volume = cast(interface, POINTER(IAudioEndpointVolume))
                # self.volume_ajuste(int(valor/4010)/100)
                vol =  max(0, min(100, abs(int(((valor-80)/3950)*100))))
                logging.info(f"NOVO VOLUME:  {vol}")
                volume.SetMasterVolumeLevelScalar(vol/100, None)

            self.incoming = self.ser.read()
        except Exception as e:
            logging.error(e)
            pass


class DummyControllerInterface:
    def __init__(self):
        self.mapping = MyControllerMap()

    def update(self):
        pyautogui.keyDown(self.mapping.button['A'])
        time.sleep(0.1)
        pyautogui.keyUp(self.mapping.button['A'])
        logging.info("[Dummy] Pressed A button")
        time.sleep(1)


if __name__ == '__main__':
    interfaces = ['dummy', 'serial']
    argparse = argparse.ArgumentParser()
    argparse.add_argument('serial_port', type=str)
    argparse.add_argument('-b', '--baudrate', type=int, default=115200)
    argparse.add_argument('-c', '--controller_interface', type=str, default='serial', choices=interfaces)
    argparse.add_argument('-d', '--debug', default=False, action='store_true')
    args = argparse.parse_args()
    if args.debug:
        logging.basicConfig(level=logging.DEBUG)

    print("Connection to {} using {} interface ({})".format(args.serial_port, args.controller_interface, args.baudrate))
    if args.controller_interface == 'dummy':
        controller = DummyControllerInterface()
    else:
        controller = SerialControllerInterface(port=args.serial_port, baudrate=args.baudrate)

    while True:
        controller.update()
