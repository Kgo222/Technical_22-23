#include <SoftwareSerial.h>
#include <string>
using namespace std;
/*#include <Servo.h>

Servo servo01;
Servo servo02;
Servo servo03;
Servo servo04;
Servo servo05;
Servo servo06; */

const byte rxPin = 3;
const byte txPin = 4;
String dataIn;
String degree;
String slider;
SoftwareSerial Bluetooth(rxPin, txPin); // Arduino(RX, TX) - HC-05 Bluetooth (TX, RX)
/*
int servo1Pos, servo2Pos, servo3Pos, servo4Pos, servo5Pos, servo6Pos; // current position
int servo1PPos, servo2PPos, servo3PPos, servo4PPos, servo5PPos, servo6PPos; // previous position
int servo01SP[50], servo02SP[50], servo03SP[50], servo04SP[50], servo05SP[50], servo06SP[50];  // for storing positions/steps */
int speedDelay = 20;
int index = 0;

void setup() {
  Bluetooth.begin(38400); // Default baud rate of the Bluetooth module
  Bluetooth.setTimeout(1);
  delay(20);

}

void loop() {
   if (Bluetooth.available() > 0) {
    dataIn = Bluetooth.readString();  // Read the data as string
    slider = dataIn.substr(1,1); //gets slider number from data
    degree = dataIn.substr(3);  //gets position in degrees from data
}
