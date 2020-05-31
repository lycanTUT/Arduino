void setup() {
  pinMode(A0, INPUT);
  Serial.begin(9600);

}

void loop() {
 int sense = analogRead(A0);
 Serial.print(sense);

}
