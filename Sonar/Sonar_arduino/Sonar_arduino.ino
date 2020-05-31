int i;
int echo = 13;
int trig = 12;
int vcc1 = 11;
int cnt = 1;
float f;
int to = 25000; //max time

void setup() {
  Serial.begin(9600);
  //Serial.println("starting...");
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
