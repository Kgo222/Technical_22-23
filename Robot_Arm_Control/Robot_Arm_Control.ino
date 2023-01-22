#include <SoftwareSerial.h>

SoftwareSerial Bluetooth(3, 4); // Arduino(RX, TX) - HC-05 Bluetooth (TX, RX)

void setup() {
  Bluetooth.begin(38400); // Default baud rate of the Bluetooth module
  Bluetooth.setTimeout(1);
  delay(20);

}

void loop() {
   if (Bluetooth.available() > 0) {
    dataIn = Bluetooth.readString();  // Read the data as string

}
