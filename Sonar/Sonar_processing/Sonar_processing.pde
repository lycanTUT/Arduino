import processing.serial.*;

Serial myPort; 

void setup() {
  size(500, 510);

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  while (myPort.available() > 0) {
    int read =  myPort.read();
    int val = 510 - (2 * read);
    float cm = map(read, 0, 255, 42, 1550);
    background(0);
    quad(200, 510, 300, 510, 300, val, 200, val);
    text((int)cm + " mm", 10, 100);
  }
}

/*
Arduino Code:

int i;
int echo = 13;
int trig = 12;
int vcc1 = 11;
int cnt = 1;
float f;
int to = 25000; //max time

void setup() {
  Serial.begin(9600);
  pinMode(vcc1, OUTPUT); //to connect to Vcc
  pinMode(echo, INPUT);
  pinMode(trig, OUTPUT);
  digitalWrite(vcc1, HIGH); //to Vcc=+5V
  digitalWrite(trig, 0); //init trig = 0
}

int ch;
void loop() {
  digitalWrite(trig, 0);
  delay(50);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);
  cnt = pulseIn(echo, 1, to); 
  if (cnt > 200) {
    dispsonar();
  }

}

void dispsonar() {
  int sen = map(cnt, 250, 9000, 0, 255);
  if (sen > 255){ sen = 255;}
  if (sen < 0){sen = 0;}
  Serial.write(sen & 0xff);
}
*/
