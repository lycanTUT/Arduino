import processing.serial.*;
Serial port;

int x = 250;
boolean hold = false;

void setup() {
  size(500, 500);
  background(0);
  noStroke();
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  fill(255);
  rect(50, 240, 400, 20);
  if (x > 430) {
    x = 430;
  }
  if (x < 50) {
    x = 50;
  }
  scroll(x);
  int send = (int)map(x, 50, 430, 0, 255);
  println(send);
  port.write(send);
}

void scroll(int xpos) {
  fill(255, 0, 0);
  square(xpos, 240, 20);
}

void mouseDragged() {
  if (hold) {
    x = mouseX;
  }
}
void mousePressed() {
  if (mouseX > 50 && mouseX < 450 && mouseY > 240 && mouseY < 260) {
    x = mouseX;
    hold = true;
  } else {
    hold = false;
  }
}

/*
#include <Servo.h>

Servo myservo;
int val;
int pos;
boolean sweep;
void setup() {
  myservo.attach(9);
  Serial.begin(9600);
}

void loop() {

}

void serialEvent() {
  val = Serial.read();
  if (val < 250) {
    pos = 180;
    sweep = false;
    val = map(val, 0, 250, 0, 180);
    myservo.write(val);
    delay(2);
  }
  else {
    if (sweep) {
      pos++;
      if (pos > 180) {
        sweep = false;
      }
    }
    else {
      pos--;
      if (pos < 0) {
        sweep = true;
      }
    }
    myservo.write(pos);
    //delay(2);
  }

}
 */
