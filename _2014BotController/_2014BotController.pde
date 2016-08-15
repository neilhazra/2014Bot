/*  
 *Neil Hazra
 *Send Data to Arduino to drive 5 servos
 *Poll Data from Logitech Joystick
*/
int portNum = 0;

import procontroll.*;
import java.io.*;
import processing.serial.*;

ControllIO controll;
ControllDevice device;
ControllStick stick;
ControllStick stick2;
ControllButton button;
boolean buttonAStatus = false;
Serial port;
String string;
float shoot = 0;
int roller = 0;
int solenoids = 0;
int  w = 0;
int  x = 0;

void setup() {
  size(550, 100);  
  textSize(20);
  controll = ControllIO.getInstance(this);
  println(Serial.list().length);
  for (int i = 0; i<Serial.list().length; i ++)  {
    print(Serial.list()[i]);
    print(" ");
    println(i);
  }
  port = new Serial(this, Serial.list()[portNum], 9600);
  port.bufferUntil('\n');
  port.write("0;0\n" );
  device = controll.getDevice("Logitech Dual Action");
  stick2 = device.getStick("X Axis Y Axis");    
  stick = device.getStick("Z Axis Z Rotation");
  stick.setTolerance(0.05f);
  stick.setMultiplier(-1);
  stick2.setTolerance(0.05f);
  stick2.setMultiplier(-1); 
  device.plug(this, "up", ControllIO.ON_PRESS, 2);
  device.plug(this, "down", ControllIO.ON_PRESS, 3);
  device.plug(this, "rollerToggle", ControllIO.ON_PRESS, 1);
  //device.plug(this, "solenoidsToggle", ControllIO.ON_PRESS, 2);
  delay(1000); //initialize it
}
// Vish of the zoo
void up(){
   shoot =1;
   delay(220);   
   shoot = 0;
}
void down(){
   shoot = -0.07;
   delay(1900);
   shoot = 0;
}
void rollerToggle()  {
  roller++;
  if(roller==2)  {
    roller = -1;
  }
}
void solenoidsToggle()  {
  solenoids++;
  if(solenoids==2)  {
    solenoids = 0;
  } 
}

void serialEvent(Serial p)  {
  text(p.readString(), 10, 60);
  text("Code by Neil Hazra", 10, 30);
}

void draw() {  
  background(150);
  w = round(1);
  x = round(1);
  string = stick.getY() + ";" + (-stick2.getY())* + ";" + roller + ";" + shoot + ";" + solenoids + ";\n";
  
  port.write(string);
  println(string);
  delay(55); //Don't lower this value, if arduino suddenly stops receiving (Serial buffer overflow), increase this value
}
