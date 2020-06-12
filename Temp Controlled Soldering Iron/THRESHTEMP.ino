#include <OneWire.h>
#include <DallasTemperature.h>
boolean state;
OneWire oneWire(2);
DallasTemperature sensors(&oneWire);

void setup() {
pinMode(8, OUTPUT);
Serial.begin(9600);
sensors.begin();
}

void loop() {
  sensors.requestTemperatures();
  Serial.print(millis());
  Serial.print(",");
  float temp = sensors.getTempCByIndex(0);
  Serial.print(temp);
  Serial.print('\n');
  if (temp > 80.5 && state == HIGH){
   digitalWrite(8, LOW);
   state == LOW;
  }
  else if(temp < 79.5 && state == LOW){
    digitalWrite(8, HIGH);
    state == HIGH;
  }
  else if(temp<80.5 && temp>79.5 && state == HIGH){
    digitalWrite(8, HIGH);
    state == HIGH;
    }
  else if(temp<80.5 && temp>79.5 && state == LOW){
    digitalWrite(8, LOW);
    state == LOW;
    }
  delay(1000);

}
