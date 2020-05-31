#define ANALOG_IN1 A1
#define ANALOG_IN2 A2

void setup() {
  Serial.begin(9600); 
  pinMode(A4, OUTPUT);
  pinMode(A5, OUTPUT);
}

void loop() {
  int val1 = analogRead(ANALOG_IN1);
  int val2 = analogRead(ANALOG_IN2);
  Serial.write(0xFC | val1 >> 8);
  Serial.write(val1 & 0xff);
  Serial.write(0x3C | val2 >> 8);
  Serial.write(val2 & 0xff);

}
