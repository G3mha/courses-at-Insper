#include <Arduino.h>

int pinClient = 7; // number of the pin used by Arduino to send data
byte msg = 0x0E; // letter E in hexadecimal
int msgBinary = int(msg); // letter E converted from hex to binary
float baudrate = 9600; // 9600 bits per second

void setup() {
  pinMode(pinClient, OUTPUT); // set the digital pin as output, as client is sending to server
  Serial.begin(baudrate); // start the serial port, setting the sending data rate to 9600 bits per second
  digitalWrite(pinClient, HIGH); // start with the pin high (1)
}

float timeSkipper(float skipTime=1, float baudrate=9600, float T0=0){
  double clock = 1 / (21 * pow(10, 6)); // time of 1 clock (T = 1/frequency), where frequency = 21MHz
  double T = 1 / baudrate; // time between each clock, in seconds
  int numberOfClocks = ceil(T / clock) + 1; // number of clocks to wait, rounded to the nearest integer
  for (int i = 0; i < int(numberOfClocks * skipTime); i++){ asm("NOP"); } // wait for the specified time
}

void loop() {
  int amountOf1s = 0; // counter for amount of 1s in the message

  digitalWrite(pinClient, 0); // send the start bit
  timeSkipper(); // aways called after sending a bit
  
  for (int i = 0; i < 8; i++){ // send the 8 bits (1 byte) of the message
    int currentBit = 1 & (msgBinary >> i); // get the current bit of the message, starting from the least significant bit
    digitalWrite(pinClient, currentBit); // send the current bit
    if (currentBit == 1){ amountOf1s++; } // count the amount of 1s in the message
    timeSkipper(); // aways called after sending a bit
  }

  int parityBit = amountOf1s % 2; // if reminder equals 0, then it's even, else it's odd
  digitalWrite(pinClient, parityBit); // send parity bit
  timeSkipper(); // aways called after sending a bit

  digitalWrite(pinClient, 1); // send the stop bit
  timeSkipper(); // aways called after sending a bit
  
  Serial.print("Data sent: ");
  Serial.println(msg, HEX); // print the sent message (in hexadecimal)
  delay(2000);
}