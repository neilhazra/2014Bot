# 2014Bot
Arduino Code control FRC team 2976 2014 yoga ball bot

The code here, running on a FRC robot is almost a drop-in replacement for the roborio. Connect the Arduino PWM Pins to the respective
Jaguar Motor controller and connect a HC-06 bluetooth module to Rx and Tx (Be sure to cross them). 

Processing code reads joystick data and packages them altogether in a semicolon delimited string. Using the RoboLib library the Arduino 
decodes the information and sets the correct motor to the correct value.

