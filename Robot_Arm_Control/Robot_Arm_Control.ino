#include <SoftwareSerial.h>
#include <Servo.h>

Servo servo1; 
SoftwareSerial Bluetooth(3,4); //Arduino(RX,TX) to HM-10 Bluetooth(TX,RX)

int servo1Next; //current position
int servo1Prev; //previous position 
String dataIn = "";

void changeServo(int* prev, int* next, Servo servo);

void setup() {
  servo1.attach(5); 
  Bluetooth.begin(9600);
  Bluetooth.setTimeout(1);
  Serial.begin(9600);

  //Servo initial positions
  servo1Prev = 90;
  servo1.write(servo1Prev);
}

void loop() {
  if(Bluetooth.available() != 0){
    Serial.print("Bluetooth Available: ");
    Serial.println(Bluetooth.available());
    }
  if(Bluetooth.available() >0){
    dataIn = dataIn+Bluetooth.readString();  // Read the data as string
    if(dataIn.endsWith("%")){ // Listening for BT communication
        //Process incoming data
         Serial.print("dataIn: ");
         Serial.println(dataIn);
         int location = dataIn.indexOf("|");
         Serial.print("location of |: ");
         Serial.println(location);
         String degree = dataIn.substring(location+1,dataIn.length()-1);  //gets only angle from data
         Serial.print("degree:");
         Serial.println(degree);
         Serial.print("Prev: ");
         Serial.println(servo1Prev);
         Serial.println(dataIn.startsWith("#1"));
         
         // SLIDER 1 changed
         if(dataIn.startsWith("#1")){ 
            servo1Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo1Next);
            changeServo(&servo1Prev, &servo1Next, servo1);
            Serial.print("Prev: ");
            Serial.println(servo1Prev);
         }
         dataIn = ""; //reset dataIn variable
    }
  }
} 

void changeServo(int* prev, int* next, Servo servo){ //pass by reference so we can change values of prev and next
  if (*prev > *next) {
        for ( int j = *prev; j >= *next; j--) {   // Run servo down
          servo.write(j);
          delay(20);    // defines the speed at which the servo rotates
        }
  }
      // If previous position is smaller then current position
  if (*prev < *next) {
      for ( int j = *prev; j <= *next; j++) {   // Run servo up
          servo.write(j);
          delay(20);
      }
   }
   *prev = *next;   // set current position as previous position
}
