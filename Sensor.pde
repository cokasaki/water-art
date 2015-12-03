//int side = 50;

//class Button {
  
//  int xpos;
//  int ypos;
  
//  Button(int x, int y){
//    xpos = x;
//    ypos = y;
//  }
  
//  void draw(){
//    noFill();
//    rectMode(CORNER);
//    rect(xpos,ypos,side,side);
//  }
  
//  boolean inside(int x,int y){
//    return xpos <= x && 
//           x <= (xpos + side) && 
//           ypos <= y && 
//           y <= (ypos + side);
//  }
  
//}

class Sensor {
 int sensorPin;
 int sensorValue = 0;
 int numBottles;
 Arduino arduino;
  
 Sensor(int pin, int bottles, Arduino a) {
   sensorPin = pin;
   numBottles = bottles;
   arduino = a;
   a.pinMode(sensorPin, Arduino.INPUT);
 }
  
 void sense() {
   sensorValue = arduino.analogRead(sensorPin);
   println(sensorValue); // 0 - 1023
 }

 boolean selected() {
   return sensorValue < 300;
 }
 
 int getNumBottles() {
   return numBottles;
 }
}