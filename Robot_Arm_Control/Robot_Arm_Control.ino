#include <SoftwareSerial.h>
#include <Servo.h>

Servo servo01;

SoftwareSerial Bluetooth(3,4); //Arduino(RX,TX) to HM-10 Bluetooth(TX,RX)

int servo1Pos; //current position
int servo1PPos; //previous position
int servo01SP[50]; //store position
int speedDelay= 20;
int index = 0;
String dataIn = "";

void setup()
{
  servo01.attach(5);
  Bluetooth.begin(9600);
  Bluetooth.setTimeout(1);
  delay(20);

  //Arm initial position
  servo1PPos = 90;
  servo01.write(servo1PPos);
}
void loop(){
  if(Bluetooth.available()>0){
     dataIn = Bluetooth.readString();  // Read the data as string
     String slider = dataIn.substring(1,2); //gets slider number from data
     if(slider.equals("1")){
      int location = dataIn.indexOf("|");
      String degree = dataIn.substring(location+1);  //gets only position from data
      int servo1Pos = degree.toInt(); //convert string to integer
     }
     // We use for loops so we can control the speed of the servo
      // If previous position is bigger then current position
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
 }
