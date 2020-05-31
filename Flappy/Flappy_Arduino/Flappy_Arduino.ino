int i;
int echo = 13;
int trig = 12;
int vcc1 = 11;
int cnt = 1;
float f;
int to = 25000; //max time

bool tog = true;

int pos = 0;    // variable to store the servo position
int mode = 0;
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
  cnt = pulseIn(echo, 1, to); //measures t in us
  //f = (cnt / 2000.0) * 346; //distance in mm
  //Serial.println(cnt);
  if (!tog) {
    if (cnt > 400 && cnt < 800) {
      Serial.print('J');
      tog = true;
    }
  }
  else {
    if (cnt < 400) {
      tog = false;
    }
  }

}
