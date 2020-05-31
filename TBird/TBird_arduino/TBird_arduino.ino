// Wiring/Arduino code:
// Read data from the serial and turn ON or OFF a light depending on the value
char val; // Data received from the serial port

void setup() {
  for (int i = 2; i <= 13; i++) {
    pinMode(i, OUTPUT); // Set pin as OUTPUT
  }
  pinMode(A5, INPUT_PULLUP);
  pinMode(A4, INPUT_PULLUP);
  pinMode(A3, INPUT_PULLUP);

  Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(A4)) {
    if (!digitalRead(A5)) {
      left();
      Serial.write('Q');
    }
    else if (!digitalRead(A3)) {
      right();
      Serial.write('Q');
    }
    else{
      Serial.write('W');
      }
  }
  else {
    if (!digitalRead(A5) && digitalRead(A3)) {
      bright();
      left();
      Serial.write('Q');
    }
    else if (digitalRead(A5) && !digitalRead(A3)) {
      bleft();
      right();
      Serial.write('Q');
    }
    else {
      bleft();
      bright();
      Serial.write('Q');
    }
  }


  while (Serial.available()) { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'L') { // If H was received
    left();
  }
  if (val == 'R') {
    right();
  }
  if (val == 'l') {
    bright();
    left();
  }
  if (val == 'r') {
    bleft();
    right();
  }
  if (val == 'B') {
    bleft();
    bright();
  }
  if (val == 'H') {
    hazard();
  }
  else {
    off();
  }
}

void left() {
  for (int l = 8; l <= 13; l++) {
    digitalWrite(l, HIGH);
    delay(50);
  }
  for (int l = 8; l <= 13; l++) {
    digitalWrite(l, LOW);
  }
}
void right() {
  for (int r = 7; r >= 2; r--) {
    digitalWrite(r, HIGH);
    delay(50);
  }
  for (int r = 7; r >= 2; r--) {
    digitalWrite(r, LOW);
  }
}
void bleft() {
  for (int l = 8; l <= 13; l++) {
    digitalWrite(l, HIGH);
  }
}
void bright() {
  for (int r = 7; r >= 2; r--) {
    digitalWrite(r, HIGH);
  }
}
void hazard() {
  for (int h = 7; h >= 3; h--) {
    digitalWrite(h, HIGH);
    digitalWrite(15 - h, HIGH);
    delay(50);
  }
  for (int h = 7; h >= 2; h--) {
    digitalWrite(h, LOW);
    digitalWrite(15 - h, LOW);
  }
}

void off() {
  for (int h = 7; h >= 2; h--) {
    digitalWrite(h, LOW);
    digitalWrite(15 - h, LOW);
  }
}
