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
