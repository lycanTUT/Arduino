import processing.serial.*;
Serial myPort; 


snake test;
food food1;
int lvl = 1;
int highScore, score;
boolean gamestate = false;
boolean moved = false;

void setup() {
  size(600, 600);
  frameRate(14);
  test = new snake();
  food1 = new food();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  highScore = 0;

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}



void draw() {
  delay(500 - (50 * lvl));
  background(0);
  if (!gamestate) {
    drawScoreboard();
  } else {
    test.move();
    test.display();
    food1.display();


    if ( dist(food1.xpos, food1.ypos, test.xpos.get(0), test.ypos.get(0)) < test.sidelen ) {
      food1.reset();
      test.addLink();
    }

    if (score > highScore) {
      highScore = score;
    }
  }
}

void mouseClicked(){
  lvl++;
}

void serialEvent(Serial myPort) {
  char val = (char)myPort.read();
  if (gamestate) {
    moved = false;
    if (val == '4') {
      if (test.dir != "right") {
        test.dir = "left";
      }
    }
    if (val == '6') {
      if (test.dir != "left") {
        test.dir = "right";
      }
    }
    if (val == '2') {
      if (test.dir != "down") {
        test.dir = "up";
      }
    }
    if (val == '8') {
      if (test.dir != "up") {
        test.dir = "down";
      }
    }
  } else {
    if (val == '#') {
      gamestate = true;
    }
  }
} 

void drawScoreboard() {
  // All of the scode for code and title

  fill(250, 0, 250);
  textSize(65);
  text( "Snake Game", width/2, 80);
  fill(250, 0, 250);

  // draw scoreboard
  //stroke(209, 140, 198);
  //fill(255, 0, 255);
  //rect(90, 70, 160, 80);
  //fill(118, 22, 167);
  textSize(20);
  text( "Level: " + lvl, width/2, 150);

  textSize(20);
  text( "Score: " + score, width/2, 200);

  //fill(118, 22, 167);
  textSize(20);
  text( "High Score: " + highScore, width/2, 250);
}

class food {
  int cols = floor(width/(20));
  int rows = floor(height/(20));
  // define varibles
  int xpos, ypos;

  //constructor
  food() {
    xpos = (floor(random(3, cols - 3))*20);
    ypos = (floor(random(3, rows - 3))*20);
  }


  // functions
  void display() {
    noStroke();
    fill(190, 0, 100);
    rect(xpos, ypos, 20, 20);
  }


  void reset() {
    xpos = (floor(random(3, cols - 3))*20);
    ypos = (floor(random(3, rows - 3))*20);
  }
}

class snake {

  //define varibles
  int len;
  float sidelen;
  String dir; 
  ArrayList <Float> xpos, ypos;

  // constructor
  snake() {
    len = 1;
    sidelen = 20;
    dir = "right";
    xpos = new ArrayList();
    ypos = new ArrayList();
    xpos.add( 300.0 );
    ypos.add( 300.0 );
  }

  // functions


  void move() {
    for (int i = len - 1; i > 0; i = i -1 ) {
      xpos.set(i, xpos.get(i - 1));
      ypos.set(i, ypos.get(i - 1));
    } 
    if (dir == "left") {
      xpos.set(0, xpos.get(0) - sidelen);
    }
    if (dir == "right") {
      xpos.set(0, xpos.get(0) + sidelen);
    }

    if (dir == "up") {
      ypos.set(0, ypos.get(0) - sidelen);
    }

    if (dir == "down") {
      ypos.set(0, ypos.get(0) + sidelen);
    }
    xpos.set(0, (xpos.get(0) + width) % width);
    ypos.set(0, (ypos.get(0) + height) % height);
    moved = true;
    // check if hit itself and if so cut off the tail
    if ( checkHit() == true) {
      len = 1;
      float xtemp = xpos.get(0);
      float ytemp = ypos.get(0);
      xpos.clear();
      ypos.clear();
      xpos.add(xtemp);
      ypos.add(ytemp);
    }
  }



  void display() {
    for (int i = 0; i <len; i++) {
      //stroke(209, 140, 198);
      fill(100, 0, 100, map(i-1, 0, len-1, 250, 50));
      rect(xpos.get(i), ypos.get(i), sidelen, sidelen);
    }
  }


  void addLink() {
    xpos.add( xpos.get(len-1) + sidelen);
    ypos.add( ypos.get(len-1) + sidelen);
    len++;
  }

  boolean checkHit() {
    for (int i = 1; i < len; i++) {
      if ( dist(xpos.get(0), ypos.get(0), xpos.get(i), ypos.get(i)) < sidelen) {
        score = test.len - 1;
        gamestate = false;
        myPort.clear();
        return true;
      }
    } 
    return false;
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
    //Serial.println('A');
  }
}
*/
