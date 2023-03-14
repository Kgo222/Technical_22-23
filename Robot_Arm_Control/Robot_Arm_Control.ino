#include <SoftwareSerial.h>
#include <Servo.h>

Servo servo1; 
Servo servo2; 
Servo servo3; 
Servo servo4; 
Servo servo5; 
Servo servo6; 

SoftwareSerial Bluetooth(3,4); //Arduino(RX,TX) to HM-10 Bluetooth(TX,RX)

int servo1Next, servo2Next, servo3Next, servo4Next,servo5Next, servo6Next; //current position
int servo1Prev, servo2Prev, servo3Prev, servo4Prev, servo5Prev, servo6Prev; //previous position 
String dataIn = "";

void changeServo(int* prev, int* next, Servo servo);

void setup() {
  servo1.attach(5); 
  servo2.attach(6); 
  servo3.attach(7); 
  servo4.attach(8); 
  servo5.attach(9); 
  servo6.attach(10); 
  Bluetooth.begin(9600);
  Bluetooth.setTimeout(1);
  Serial.begin(9600);

  //Servo initial positions
  servo1Prev = 90;
  servo1.write(servo1Prev);
  servo2Prev = 150;
  servo2.write(servo2Prev);
  servo3Prev = 35;
  servo3.write(servo3Prev);
  servo4Prev = 140;
  servo4.write(servo4Prev);
  servo5Prev = 85;
  servo5.write(servo5Prev);
  servo6Prev = 80;
  servo6.write(servo6Prev);
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

         //SLIDER 2 changed
         if(dataIn.startsWith("#2")){ 
            servo2Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo2Next);
            changeServo(&servo2Prev, &servo2Next, servo2);
            Serial.print("Prev: ");
            Serial.println(servo2Prev);
         }

         //SLIDER 3 changed
          if(dataIn.startsWith("#3")){ 
            servo3Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo3Next);
            changeServo(&servo3Prev, &servo3Next, servo3);
            Serial.print("Prev: ");
            Serial.println(servo3Prev);
         }

         //SLIDER 4 changed 
         if(dataIn.startsWith("#4")){ 
            servo4Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo4Next);
            changeServo(&servo4Prev, &servo4Next, servo4);
            Serial.print("Prev: ");
            Serial.println(servo4Prev);
         }

         //SLIDER 5 changed
         if(dataIn.startsWith("#5")){ 
            servo5Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo5Next);
            changeServo(&servo5Prev, &servo5Next, servo5);
            Serial.print("Prev: ");
            Serial.println(servo5Prev);
         }

         //SLIDER 6 changed
         if(dataIn.startsWith("#6")){ 
            servo6Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo6Next);
            changeServo(&servo6Prev, &servo6Next, servo6);
            Serial.print("Prev: ");
            Serial.println(servo6Prev);
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
