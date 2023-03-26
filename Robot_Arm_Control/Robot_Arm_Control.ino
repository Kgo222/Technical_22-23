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
  servo1.attach(5); //Claw
  servo2.attach(6);  //Wrist
  servo3.attach(7);  //Elbow 
  servo4.attach(8);  //Elbow 1
  servo5.attach(9); //Shoulder
  servo6.attach(10); //Base
  Bluetooth.begin(9600);
  Bluetooth.setTimeout(1);
  Serial.begin(9600);

  //Servo initial positions
  servo1Prev = 50;
  servo1.write(servo1Prev);
  delay(500); //delay a second between each change
  servo2Prev = 0;
  servo2.write(servo2Prev);
  delay(500);
  servo3Prev = 25;
  servo3.write(servo3Prev);
  delay(500);
  servo4Prev = 180;
  servo4.write(servo4Prev);
  delay(500);
  servo5Prev = 160;
  servo5.write(servo5Prev);
  delay(500);
  servo6Prev = 40;
  servo6.write(servo6Prev);
  delay(500);
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
            Serial.print("Current Read from servo:");
            Serial.println(servo1.read());
            servo1Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo1Next);
            changeServo(&servo1Prev, &servo1Next, servo1);
            Serial.print("Current Read from servo:");
            Serial.println(servo1.read());
            Serial.print("Prev: ");
            Serial.println(servo1Prev);
         }

         //SLIDER 2 changed
         else if(dataIn.startsWith("#2")){ 
            servo2Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo2Next);
            changeServo(&servo2Prev, &servo2Next, servo2);
            Serial.print("Prev: ");
            Serial.println(servo2Prev);
         }

         //SLIDER 3 changed
          else if(dataIn.startsWith("#3")){ 
            servo3Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo3Next);
            changeServo(&servo3Prev, &servo3Next, servo3);
            Serial.print("Prev: ");
            Serial.println(servo3Prev);
         }

         //SLIDER 4 changed 
         else if(dataIn.startsWith("#4")){ 
            servo4Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo4Next);
            changeServo(&servo4Prev, &servo4Next, servo4);
            Serial.print("Prev: ");
            Serial.println(servo4Prev);
         }

         //SLIDER 5 changed
         else if(dataIn.startsWith("#5")){ 
            servo5Next = degree.toInt(); //convert degree string to integer
            Serial.print("Next: ");
            Serial.println(servo5Next);
            changeServo(&servo5Prev, &servo5Next, servo5);
            Serial.print("Prev: ");
            Serial.println(servo5Prev);
         }

         //SLIDER 6 changed
         else if(dataIn.startsWith("#6")){ 
            servo6Next = degree.toInt(); //convert degree string to integer
            Serial.print("Current Read from servo:");
            Serial.println(servo6.read());
            Serial.print("Next: ");
            Serial.println(servo6Next);
            changeServo(&servo6Prev, &servo6Next, servo6);
            Serial.print("Prev: ");
            Serial.println(servo6Prev);
            Serial.print("Current Read from servo:");
            Serial.println(servo6.read());
         }

         else if(dataIn.startsWith("RESET")){ //Put arms back to original places
          int reset1 = 50;
          int reset2 = 0;
          int reset3 = 25;
          int reset4 = 180;
          int reset5 = 160;
          int reset6 = 40;
          changeServo(&servo1Prev, &reset1, servo1);
          changeServo(&servo2Prev, &reset2, servo2);
          changeServo(&servo3Prev, &reset3, servo3);
          changeServo(&servo4Prev, &reset4, servo4);
          changeServo(&servo5Prev, &reset5, servo5);
          changeServo(&servo6Prev, &reset6, servo6);
          Serial.println("RESET COMPLETE");
         }
         else if(dataIn.startsWith("WAVE")){ //Makes Arm do a waving motion
          //Angle change steps
          int first = 135;
          int second = 33;
          int third = 50;
          int fourth = 0;
          int fifth = 180;
          int sixth = 0;
          int seventh = 90;
          int eighth = 25;
          int ninth = 45;
          int tenth = 160;
          
          changeServo(&servo5Prev, &first, servo5); //move sholder up
          changeServo(&servo3Prev, &second, servo3); //move elbow down
          changeServo(&servo1Prev, &third, servo1);//close claw
          changeServo(&servo2Prev, &fourth, servo2); //move wrist back and forth (like royal wave)
          changeServo(&servo2Prev, &fifth, servo2);
          changeServo(&servo2Prev, &sixth, servo2);
          changeServo(&servo2Prev, &seventh, servo2);
          changeServo(&servo1Prev, &eighth, servo1);//open claw
          changeServo(&servo3Prev, &ninth, servo3); //move elbow back up
          changeServo(&servo5Prev, &tenth, servo5); //move sholder down
          
          Serial.println("WAVE COMPLETE");
         }
         else if(dataIn.startsWith("PICKUP")){ //Makes arm do pickup box sequence
          int first = 143;
          int second = 135;
          int third = 5;
          int fourth = 90;
          int fifth = 0;
          int sixth = 95;
          int seventh = 50;
          int eighth = 135;
          int ninth = 137;
          int tenth = 90;
          int eleventh = 100;
          int twelth = 0;
          int thirteenth = 40;
          int fourteenth = 160;
          int fifteenth = 140;
          int sixteenth = 0;
          int seventeenth = 50;
          

          changeServo(&servo3Prev, &first, servo3);
          changeServo(&servo5Prev, &second, servo5);
          changeServo(&servo6Prev,&third, servo6);
          changeServo(&servo2Prev,&fourth,servo2);
          changeServo(&servo1Prev, &fifth, servo1);
          changeServo(&servo5Prev, &sixth, servo5);
          changeServo(&servo1Prev, &seventh, servo1);
          changeServo(&servo5Prev, &eighth, servo5);
          changeServo(&servo3Prev, &ninth,servo3);
          changeServo(&servo6Prev, &tenth, servo6);
          changeServo(&servo5Prev, &eleventh, servo5);
          changeServo(&servo1Prev, &twelth, servo1);
          changeServo(&servo6Prev, &thirteenth, servo6);
          //changeServo(&servo3Prev, &fourteenth, servo3);
          changeServo(&servo2Prev, &sixteenth, servo2);
          changeServo(&servo5Prev, &fifteenth, servo5);
          changeServo(&servo1Prev, &seventeenth, servo1);
          Serial.println("SEQUENCE COMPLETE");
         }
         dataIn = ""; //reset dataIn variable
    }
  }
} 

void changeServo(int* prev, int* next, Servo servo){ //pass by reference so we can change values of prev and next
  Serial.print("next:");
  Serial.println(*next);
  if (*prev > *next) {
        for ( int j = *prev; j >= *next; j--) {   // Run servo down
          servo.write(j);
          delay(15);    // defines the speed at which the servo rotates
        }
  }
      // If previous position is smaller then current position
  if (*prev < *next) {
      for ( int j = *prev; j <= *next; j++) {   // Run servo up
          servo.write(j);
          delay(15);
      }
   }
   *prev = *next;   // set current position as previous position
}
