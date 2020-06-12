#include <LiquidCrystal.h>

//Pins for Ultrasonic
//int GND1 = 7;
//int GND2 = 6;
int echo = A1;
int trig = 13;
//int VCC = 3;

const int rs = 7, en = 6, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

int increase = A5;
int decrease = A4;
int play = A3;
bool state = false;
int currentPress;
int prevPress = HIGH;
long time = 0;
long debounce = 200;

//Pins for Motor
int MLdir = 11;
int MRdir = 8;
int MLspd = 10;
int MRspd = 9;

float cm;
float us;

int pwm;
float target = 10;
float PID, PID_p, PID_i, PID_d;
float K_p, K_i, K_d, error, low_error, up_error, prev_error;
double currentTime, elapsedTime;

void setup() {
  Serial.begin(9600);
  //pinMode(GND1, OUTPUT);
  //pinMode(GND2, OUTPUT);
  //pinMode(VCC, OUTPUT);
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);

  pinMode(MLdir, OUTPUT);
  pinMode(MRdir, OUTPUT);
  pinMode(MLspd, OUTPUT);
  pinMode(MRspd, OUTPUT);
  delay(50);

  pinMode(increase, INPUT_PULLUP);
  pinMode(decrease, INPUT_PULLUP);
  pinMode(play, INPUT_PULLUP);

  //digitalWrite(GND1, LOW);
  //digitalWrite(GND2, LOW);
  //digitalWrite(VCC, HIGH);

  K_p = 3.1;
  K_i = 0.5;
  K_d = 1.3;
  low_error = -1.95;
  up_error = 1.95;

  lcd.begin(16, 2);
}

void loop() {

  if (digitalRead(increase) == 0) {
    target++;
  }
  if (digitalRead(decrease) == 0) {
    target--;
  }

  if (target < 0) {
    target = 0;
  }
  else if (target > 60) {
    target = 60;
  }

  currentPress = digitalRead(play);
  if (currentPress == LOW && prevPress == HIGH && millis() - time > debounce) {
    if (state) {
      state = false;
    }
    else {
      state = true;
    }
    time = millis();
  }

  prevPress = currentPress;

  currentTime = millis();
  digitalWrite(trig, 0);
  delay(50);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);

  us = pulseIn(echo, 1, 25000);
  cm = (us - 170) / 56;

  error = cm - target;

  //Integral I Term
  if (low_error < error && error < up_error) {
    PID_i = PID_i + (K_i * error);
  }
  else{
    PID_i = 0;
    PID = 0;
  }
  //Proportional P Term
  PID_p = K_p * error;

  //Derivative D Term
  PID_d = K_d * (error - prev_error) / (currentTime - elapsedTime);

  //Total PID Value
  PID = PID_p + PID_i + PID_d;


  if (cm < target) {
    pwm = map(PID, 0, -295, 35, 255);
    digitalWrite(MLdir, HIGH);
    digitalWrite(MRdir, HIGH);
  }
  else {
    pwm = map(PID, 0, 295, 35, 255);
    digitalWrite(MLdir, LOW);
    digitalWrite(MRdir, LOW);
  }

  if (pwm < 0) {
    pwm = 0;
  }
  else if (pwm > 255) {
    pwm = 255;
  }

  if (!state) {
    pwm = 0;
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Target: ");
    lcd.print(target);
    lcd.setCursor(0, 1);
    lcd.print("Paused");
    lcd.display();
  }

  else {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Target: ");
    lcd.print(target);
    lcd.setCursor(0, 1);
    lcd.print("Distance: ");
    lcd.print(cm);
    lcd.display();
  }


  analogWrite(MLspd, pwm);
  analogWrite(MRspd, pwm);

  Serial.print(currentTime);
  Serial.print(",");
  Serial.println(-error);
  //Serial.print(",");
  //Serial.println(target);

                 prev_error = error;
                 elapsedTime = currentTime;

}
