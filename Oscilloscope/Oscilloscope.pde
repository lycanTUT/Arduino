/*
 * Oscilloscope
 */
import processing.serial.*;

Serial port;  // Create object from Serial class
int val; // Data received from the serial port
int ch1;
int ch2;
int[] values1;
int[] values2;
int[] theTime;

void setup() 
{
  size(640, 480);
  // Open the port that the board is connected to and use the same speed (9600 bps)
  port = new Serial(this, Serial.list()[0], 9600);
  values1 = new int[width];
  values2 = new int[width];
  theTime = new int[width];
  smooth();
}

int getY(int val) {
  return (int)(val / 1023.0f * height) - 1;
}

void draw()
{
  while (port.available() >= 4) { // 4 bytes of data per reading
    val = port.read();
    if ((val & 0xFC) == 0xFC) { //header for blue channel is 0xFC
      ch1 = ((val << 8) | port.read()) & 0x3FF;
      println(ch1);
    } else if ((val & 0xFC) == 0x3C) { //header for yellow channel is 0x3C
      ch2 = ((val << 8) | port.read()) & 0x3FF;
      println(ch2);
    }
  }

  for (int i=0; i<width-1; i++) { // shift the values
    values1[i] = values1[i+1];
    values2[i] = values2[i+1];
    theTime[i] = theTime[i+1];
  }
  values1[width-1] = ch1;
  values2[width-1] = ch2;
  theTime[width-1] = millis();
  background(0);
  stroke(0, 0, 255); // blue channel
  for (int x=1; x<width; x++) {
    line(width-x, height-1-getY(values1[x-1]), 
      width-1-x, height-1-getY(values1[x]));
  }
  stroke(255, 255, 0); // yellow channel
  for (int x=1; x<width; x++) {
    line(width-x, height-1-getY(values2[x-1]), 
      width-1-x, height-1-getY(values2[x]));
  }
}

void keyPressed(){ //press a key to save the data points on the screen and exit
  String[] savep = new String[values1.length];
  for (int s = 0; s < values1.length; s++){
    savep[s] = theTime[s] + "," + values1[s] + "," + values2[s];
  }
  saveStrings("Oscilloscope.csv", savep);
  delay(50);
  exit(); // Stop the program
}

/*
// The Arduino code.
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
 */
