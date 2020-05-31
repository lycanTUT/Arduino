char keys[4][3] = {
  { '1', '2', '3'},
  {'4', '5', '6'},
  {'7', '8', '9'},
  {'*', '0', '#'},
};
void setup() {
  Serial.begin(9600);
}

void loop() {
  boolean pressed = false;
  int cp;
  for (int c = 6; c <= 8; c++) {
    pinMode(c, INPUT_PULLUP);
    if (!digitalRead(c)) {
      cp = c - 6;
    }
    pinMode(c, INPUT);
  }

  int rp;
  for (int r = 2; r <= 5; r++) {
    pinMode(r, INPUT_PULLUP);
    if (!digitalRead(r)) {
      rp = r - 2;
      pressed = true;
    }
    pinMode(r, INPUT);
  }
  if (pressed) {
    Serial.println(keys[rp][cp]);
  }
  else {
    //Serial.println('A');
  }
}
