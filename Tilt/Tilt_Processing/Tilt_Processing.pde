import processing.serial.*;
Serial port;

void setup() {
  size(500, 500);
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  while (port.available() > 0) {
    if (port.read() == 'R') {
      background(0);
      triangle(100, 100, 100, 400, 400, 250);
    } else if (port.read() == 'L') {
      background(0);
      triangle(400, 100, 400, 400, 100, 250);
    } else if (port.read() == 'D') {
      background(0);
      triangle(100, 100, 250, 400, 400, 100);
    } else if (port.read() == 'U') {
      background(0);
      triangle(100, 400, 250, 100, 400, 400);
    }
  }
}

/*
int B = 10;
int A = 11;
int gnd = 12;
int vcc = 13;

void setup() {
  pinMode(B,INPUT);
  pinMode(A,INPUT);
  pinMode(gnd,OUTPUT);
  pinMode(vcc,OUTPUT);

  digitalWrite(gnd,LOW);
  digitalWrite(vcc, HIGH);

  Serial.begin(9600);
}

void loop() {
  if (digitalRead(A) && digitalRead(B)){
    Serial.write("D");
  }
  else if (digitalRead(A) && !digitalRead(B)){
    Serial.println("L");
  }
  else if (!digitalRead(A) && digitalRead(B)){
    Serial.println("R");
  }
  else {
    Serial.println("U");
  }
}
*/
