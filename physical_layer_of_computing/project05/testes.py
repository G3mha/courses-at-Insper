from pyexpat import ParserCreate


imageR = 'img/Capturar2.png'
txBuffer = open(imageR,'rb').read()
print(len(txBuffer))
parte = str(txBuffer[4:10])
i = 0
i = 114
i = 114*2
print('info da imagem', txBuffer[i:i+114])
print('recorte :' , parte)
print(parte.count('\\x'))
# print(parte.split('\\x'))

# esperado =  int.from_bytes(b'\x00',byteorder='little')
# esperado =  int.from_bytes(txBuffer,byteorder='little')

# print(esperado)

head = 'valor'

payLOAD = '114BYTES'

eop = 'AAA'  

pacotes =  head + payLOAD + eop