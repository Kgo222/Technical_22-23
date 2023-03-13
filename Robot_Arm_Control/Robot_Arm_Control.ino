#include <SoftwareSerial.h>
#include <Servo.h>

#define ledPin 13

Servo servo01; 
SoftwareSerial Bluetooth(3,4); //Arduino(RX,TX) to HM-10 Bluetooth(TX,RX)

int servo1Pos; //current position
int servo1PPos; //previous position 
int state = 0;
String dataIn = "";
String function = "0";

void setup() {
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
  servo01.attach(5); 
  Bluetooth.begin(9600);
  Bluetooth.setTimeout(1);

  //Servo initial positions
  servo1PPos = 90;
  servo01.write(servo1PPos);
}

void loop() {
  if(Bluetooth.available() > 0){ // Listening for BT communication
       dataIn = Bluetooth.readString();  // Read the data as string
       int location = dataIn.indexOf("|");
       function = dataIn.substring(1,location); //gets slider number from data
       String degree = dataIn.substring(location+1,dataIn.length());  //gets only angle from data
       if(degree == "!"){
          servo1Pos = servo1Pos; //Fill with button function later
        }
       else{ //degree is an acutal nnumber
        if(function == "1"){ // SLIDER 1
          servo1Pos = degree.toInt(); //convert degree string to integer
       }
     }
  }
   //Controling Servo 1
    if (servo1PPos > servo1Pos) {
        for ( int j = servo1PPos; j >= servo1Pos; j--) {   // Run servo down
          servo01.write(j);
          delay(20);    // defines the speed at which the servo rotates
        }
      }
      // If previous position is smaller then current position
      if (servo1PPos < servo1Pos) {
        for ( int j = servo1PPos; j <= servo1Pos; j++) {   // Run servo up
          servo01.write(j);
          delay(20);
        }
      }
      servo1PPos = servo1Pos;   // set current position as previous position
 
} 
