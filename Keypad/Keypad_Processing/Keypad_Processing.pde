import processing.serial.*;
Serial port;

char keys[][] = {
  { '1', '2', '3'}, 
  {'4', '5', '6'}, 
  {'7', '8', '9'}, 
  {'*', '0', '#'}, 
};

void setup() {
  size(500, 640);
  background(0);
  port = new Serial(this, Serial.list()[0], 9600);
}
void draw() {
  while (port.available() > 0) {
    char val = (char)port.read();
    if (val == 'A') {
      wit();
    } else {
      for (int r = 0; r < 4; r++) {
        for (int c = 0; c < 3; c++) {
          if (val == keys[r][c]) {
            fill(255, 150, 0);
            square(50 + (c * 150), 50 + (r * 150), 100);
            //println((char)keys[r][c]);
          }
        }
      }
    }
  }
}


void wit() {
  fill(255);
  for (int r = 0; r < 4; r++) {
    for (int c = 0; c < 3; c++) {
      square(50 + (c * 150), 50 + (r * 150), 100);
      //println((char)keys[r][c]);
    }
  }
}

/*
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
    Serial.println('A');
  }
}
*/
