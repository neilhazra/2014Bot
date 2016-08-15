#include <Arduino.h>
/*
 *Neil Hazra
 *Send Data via Processing: 5 floats, semicolon delimiter, add semicolons till reading newe line
 *Arduino Code control FRC team 2976 2014 yoga ball bot
 */
#include <RoboLib.h>
#include <Servo.h>
const int dataSizeConst = 6;
RoboLib myBot(dataSizeConst,dataSizeConst*5);
float* processedData;
Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;
void setup() {
  myBot.begin(9600);
  servo1.attach(A1);
  servo2.attach(A0);
  servo3.attach(A2);
  servo4.attach(A3);
}
void serialEvent()  {
   myBot.saveData();
}
void loop() {
  processedData = myBot.getData();
  servo1.writeMicroseconds(mapf(processedData[0],1,-1,670,2330)); //right
  servo2.writeMicroseconds(mapf(processedData[1],1,-1,670,2330)); //left
  servo3.writeMicroseconds(mapf(processedData[2],1,-1,670,2330)); //shoot
  servo4.writeMicroseconds(mapf(processedData[3],1,-1,670,2330)); //roller
  myBot.printInfo();
  while(myBot.fatalError())  {
    servo1.writeMicroseconds(1500);
    servo2.writeMicroseconds(1500);
    servo3.writeMicroseconds(1500);
    servo4.writeMicroseconds(1500);
  }
}
float mapf(float x, float in_min, float in_max, float out_min, float out_max)
{
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
gm
