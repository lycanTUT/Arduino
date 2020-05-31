import processing.serial.*;

Serial port;  // Create object from Serial class

void setup() 
{
  size(600, 600, P3D);
  background(0);
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw()
{
  translate(width/2, height/2); 
    char val = (char)port.read();
  if (val == 0xff) {
    println("start");
    int hor = port.read();
    int ver = port.read();
    int rad = port.read();
    print(hor);
    print(",");
    print(ver);
    print(",");
    println(rad);
    rotateY(radians(hor) - (PI/4));
    rotateX(-radians(ver));
    translate(0, 0, -rad);
    noStroke();
    lights();
    sphere(5);
  }
}

/*
#include <Servo.h>

Servo myservo1;
Servo myservo2;
int pos1 = 0;
int pos2 = 0;
int echo = 13;
int trig = 12;
int vcc = 11;

void setup() {
  myservo1.attach(5);  // attaches the servo on pin 9 to the servo object
  myservo2.attach(6);  // attaches the servo on pin 9 to the servo object
  pinMode(echo, INPUT);
  pinMode(trig, OUTPUT);
  pinMode(vcc, OUTPUT);
  digitalWrite(vcc, HIGH);

  Serial.begin(9600);
}

void loop() {
  for (pos1 = 0; pos1 <= 90; pos1 += 1) { // goes from 0 degrees to 180 degrees
    myservo1.write(pos1);
    for (pos2 = 0; pos2 <= 90; pos2 += 1) {
      myservo2.write(pos2); // tell servo to go to position in variable 'pos'
      int r = scan();
      Serial.write(0xff);
      Serial.write(pos1 & 0xff);
      Serial.write(pos2 & 0xff);
      Serial.write(r & 0xff);
    }
  }

}

int scan() {
  digitalWrite(trig, 0);
  delay(50);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);
  float cnt = pulseIn(echo, 1, 25000);
  if (cnt > 200) {
    float sc = map(cnt, 200, 1600, 0, 255);
    return sc;
  }
}

*/
