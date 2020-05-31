import processing.serial.*;

Serial myPort;      // The serial port
int whichKey = -1;  // Variable to hold keystoke values
int inByte = -1;    // Incoming serial data

void setup() {
  size(400, 300);
  // create a font with the third font available to the system:
  PFont myFont = createFont(PFont.list()[2], 14);
  textFont(myFont);

  // List all the available serial ports:
  printArray(Serial.list());

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);
  text("Last Received: " + inByte, 10, 130);
  text("Last Sent: " + whichKey, 10, 100);
}

void serialEvent(Serial myPort) {
  inByte = myPort.read();
}

void keyPressed() {
  // Send the keystroke out:
  myPort.write(key);
  whichKey = key;
}
/*
// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 17;  
int switchPin2 = 18;
int switchPin3 = 19;// Switch connected to pin 4
int val;

void setup() {
  pinMode(switchPin, INPUT_PULLUP);
  pinMode(switchPin2, INPUT_PULLUP); 
  pinMode(switchPin3, INPUT_PULLUP); // Set pin 0 as an input
  pinMode(8, OUTPUT); // Set pin as OUTPUT
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == LOW) {  // If switch is ON,
    Serial.write(99);               // send 1 to Processing
  }  
  if (digitalRead(switchPin2) == LOW) {  // If switch is ON,
    Serial.write(100);               // send 1 to Processing
  } 
  if (digitalRead(switchPin3) == LOW) {  // If switch is ON,
    Serial.write(101);               // send 1 to Processing
  }   
  while (Serial.available()) { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'a') { // If H was received
    digitalWrite(8, HIGH); // turn the LED on
    delay(250);
  } 
  else {
    digitalWrite(8, LOW); // Otherwise turn it OFF
  }                           
}



*/