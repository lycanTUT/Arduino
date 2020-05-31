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
    Serial.print('8');
  }
  else if (digitalRead(A) && !digitalRead(B)){
    Serial.print('4');
  }
  else if (!digitalRead(A) && digitalRead(B)){
    Serial.print('6');
  }
  else {
    Serial.print('2');
  }
}
