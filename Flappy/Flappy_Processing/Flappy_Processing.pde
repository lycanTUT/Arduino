import processing.serial.*;

Serial myPort; 

int val;
PImage backImg, birdImg, wallImg, startImg;
int cmo = -12;
int cmox = 1;
int gdelay = 50;
int gamestate = 1, score = 0, highScore = 0, x = -200, y, vy = 0;
int wx[] = new int[2], wy[] = new int[2];
void setup() {
  size(600, 800);
  fill(0);
  textSize(40);  
  birdImg =loadImage("shark.png");
  backImg =loadImage("SEA.jpg");
  wallImg =loadImage("ANKOR.png");
  startImg=loadImage("startpage.jpg");

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}
void draw() { //runs 60 times a second
  if (gamestate == 0) {
    delay(gdelay);
    imageMode(CORNER);
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0);
    x -= cmox; //6
    vy += 1;
    y += vy;
    if (x == -1800) x = 0;
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      image(wallImg, wx[i], wy[i] - (wallImg.height/2+100));
      image(wallImg, wx[i], wy[i] + (wallImg.height/2+100));
      if (wx[i] < 0) {
        wy[i] = (int)random(200, height-200);
        wx[i] = width;
      }
      if (wx[i] == width/2) highScore = max(++score, highScore);
      if (y>height||y<0||(abs(width/2-wx[i])<25 && abs(y-wy[i])>100)) gamestate=1;
      wx[i] -= 6;
    }
    image(birdImg, width/2, y);
    text(""+score, width/2+30, 300);
  } else {
    imageMode(CENTER);
    image(startImg, width/2, height/2);
    fill(255);
    text("High Score:"+highScore, 15, 600);
  }
}

void serialEvent(Serial myPort) {
  if (myPort.read() == 'J') {
    vy = cmo; //-16
    if (gamestate==1) {
      wx[0] = 600;
      wy[0] = y = height/2;
      wx[1] = 900;
      wy[1] = 600;
      x = gamestate = score = 0;
      cmo = -16;
    }
  }
}

///////////
/*
Arduino Code:

int i;
int echo = 13;
int trig = 12;
int vcc1 = 11;
int cnt = 1;
float f;
int to = 25000; //max time

bool tog = false;

int pos = 0;    // variable to store the servo position
int mode = 0;
void setup() {
  Serial.begin(9600);
  //Serial.println("starting...");
  pinMode(vcc1, OUTPUT); //to connect to Vcc
  pinMode(echo, INPUT);
  pinMode(trig, OUTPUT);
  digitalWrite(vcc1, HIGH); //to Vcc=+5V
  digitalWrite(trig, 0); //init trig = 0
}

int ch;
void loop() {
  digitalWrite(trig, 0);
  delay(50);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);
  cnt = pulseIn(echo, 1, to); //measures t in us

  if (!tog) {
    if (cnt > 400 && cnt < 800) {
      Serial.print('J');
      tog = true;
    }
  }
  else {
    if (cnt < 400) {
      tog = false;
    }
  }

}
*/
