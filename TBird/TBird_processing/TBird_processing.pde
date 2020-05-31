boolean left = false;
boolean right = false;
boolean hazard = false;
boolean brake = false;

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;  

void setup() {
  size(640, 400);
  background(0);
  rect(50, 50, 100, 100); //left
  rect(270, 50, 100, 100); //hazard
  rect(490, 50, 100, 100); //right
  rect(270, 250, 100, 100); //brake
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  while (myPort.available() > 0) {
    if (myPort.read() == 'Q') {
      fill(0, 255, 0);
    }
    else {
      fill(0);
    }
    circle(50, 200, 50);
  }
  
  
  if (hazard) {
    myPort.write('H');
  } else if (!brake && left && !right) {
    myPort.write('L');
  } else if (!brake && !left && right) {
    myPort.write('R');
  } else if (brake && left && !right) {
    myPort.write('l');
  } else if (brake && !left && right) {
    myPort.write('r');
  } else if (brake && !left && !right) {
    myPort.write('B');
  } else {
    myPort.write('x');
  }
}

void mousePressed() {
  fill(255);
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= 50 && mouseY <= 150) { //left
    if (!left && !right) {
      fill(255, 150, 0);
      left = true;
    } else { 
      left = false;
    }
    rect(50, 50, 100, 100);
  }
  if (mouseX >= 270 && mouseX <= 370 && mouseY >= 50 && mouseY <= 150) { //hazard
    if (hazard) {
      hazard = false;
    } else {
      fill(255, 0, 0); 
      hazard = true;
    }
    rect(270, 50, 100, 100);
  }
  if (mouseX >= 490 && mouseX <= 590 && mouseY >= 50 && mouseY <= 150) { //right
    if (!right && !left) {
      fill(255, 150, 0);
      right = true;
    } else {
      right = false;
    }
    rect(490, 50, 100, 100);
  }
  if (mouseX >= 270 && mouseX <= 370 && mouseY >= 250 && mouseY <= 350) { //brake
    if (brake) {
      brake = false;
    } else {
      fill(255, 0, 0); 
      brake = true;
    }
    rect(270, 250, 100, 100);
  }
}
