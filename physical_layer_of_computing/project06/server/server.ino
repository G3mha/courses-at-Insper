#include <Arduino.h>

int pinServer = 7; // number of the pin used by Arduino to receive data
float baudrate = 9600; // 9600 bits per second
int msg;

void setup() {
  pinMode(pinServer, INPUT); // set the digital pin as input, as server is receiving from client
  Serial.begin(baudrate); // start the serial port, setting the receiving data rate to 9600 bits per second
}

float timeSkipper(float skipTime=1, float baudrate=9600, float T0=0){
  double clock = 1 / (21 * pow(10, 6)); // time of 1 clock (T = 1/frequency), where frequency = 21MHz
  double T = 1 / baudrate; // time between each clock, in seconds
  int numberOfClocks = floor(T / clock) + 1; // number of clocks to wait, rounded to the nearest integer
  for (int i = 0; i < int(numberOfClocks * skipTime); i++){ asm("NOP"); } // wait for the specified time
}

void loop() {
  if (digitalRead(pinServer) == 0){
    int amountOf1s = 0;
    timeSkipper(1.5); // positioning the moment to read bits in the middle of each bit (therefore the start bit is ignored)
    for (int i = 0; i < 8; i++){
      int currentBit = digitalRead(pinServer); // read the current bit
      timeSkipper(); // aways called after reading a bit
      if (currentBit == 1){ amountOf1s++; } // count the amount of 1s in the message
      msg |= (currentBit << i); // add the current bit to the message
    }
    int parityBitReceived = digitalRead(pinServer); // read the parity bit received
    int parityBitCalculated = (amountOf1s % 2); // calculate the parity bit from the sent message
    if (parityBitReceived == parityBitCalculated){ // if the parity bit received is equal to the parity bit calculated, then the message is correct
      Serial.print("Data received: ");
      Serial.println(msg, HEX);
      Serial.println("Parity bit is correct");
    } else { // if the parity bit received is different from the parity bit calculated, then the message is incorrect
      Serial.println("ERROR. Parity bit is NOT correct");
    }
    delay(1000);
  }
}