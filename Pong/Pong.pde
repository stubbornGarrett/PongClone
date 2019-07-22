// OBJECTS
PFont buttonFont, scoreFont, countdownFont, controlFont;
Playfield playfield;
Ball ball;
Player playerOne;
Player playerTwo;
MainMenu mainMenu;

//SETTINGS
float playerWidth  = 10;
float playerHeight = 100;
float ballSize  = 20;
float ballSpeed =  5;
String playerOneName = "Player 1";
String playerTwoName = "Player 2";
color backgroundColor = color(15);

//VARIABLES
String  debugInfos; //FPS and other variables
boolean debugOn    = false;
boolean playerTurn = false;
boolean playActive = false;
boolean botActive  = true;
long lastTime      = millis();
int countdownSec   = 4;
enum GameState{
  MENU, START, PLAY, GOAL, PAUSE
}
GameState activeState;

void setup(){
  size(900, 900);
  //println(PFont.list());
  buttonFont = createFont("Lucida Console", 42);
  scoreFont = createFont("Lucida Console", 32);
  countdownFont = createFont("Lucida Console", 92);
  controlFont = createFont("Lucida Console", 24);
  translate(width/2, height/2);
  playfield = new Playfield(0, 0, width-40, height-40);
  ball      = new Ball(playfield.position.x, playfield.position.y, ballSize, ballSpeed);
  playerOne = new Player(-playfield.wid/2+20, 0, playerWidth, playerHeight, playfield.realHeight()/30, 1, playerOneName);
  playerTwo = new Player( playfield.wid/2-20, 0, playerWidth, playerHeight, playfield.realHeight()/30, 2, playerTwoName);
  mainMenu  = new MainMenu();
  activeState = GameState.MENU;
}

//Game Loop
void draw(){
  background(backgroundColor);
  translate(width/2, height/2);
  
  switch(activeState){
    case MENU:
      mainMenu.display();
      break;
    case START:
      if(countdownSec >= 0){
        countdown();
        break;
      }
      countdownSec = 4;
      playActive  = true;
      activeState = GameState.PLAY;
      break;
    case PLAY:
      updatePlayfieldElements();
      displayPlayfieldElements();
      if(ball.position.x < playfield.leftEdge() || ball.position.x > playfield.rightEdge()){
        activeState = GameState.GOAL;
      }
      break;
    case GOAL:
      updateGoal();
      break;
    case PAUSE:
      displayPlayfieldElements();
      fill( 255, 255, 255, 40);
      rect(-width/2,-height/2, width, height);
      fill( 0, 0, 0, 10);
      rect(-width/2,-height/2, width, height);
      textAlign(CENTER);
      textFont(countdownFont);
      fill(255);
      text("PAUSE", playfield.position.x, playfield.position.y);
      break;
    default:
      break;
  }

  //Debug
  if(debugOn){
    playfield.displayEdges();
    ball.displayEdges();
    playerOne.displayEdges();
    playerTwo.displayEdges();
    textAlign(LEFT);
    textFont(controlFont);
    fill(0, 200, 0);
    debugInfos = "FPS:" + String.format("%.2f", frameRate) + " | Ballspeed:" + ball.speed;
    text(debugInfos, playfield.leftEdge()+3, playfield.topEdge()+27);
  }
}

void countdown(){
  if(millis() - lastTime > 1000){
    lastTime = millis();
    countdownSec -= 1;
  }
  background(backgroundColor);
  
  displayPlayfieldElements();
  
  fill(155, 155, 155, 240);
  noStroke();
  ellipse(playfield.position.x, playfield.position.y, 90, 100);
  
  textAlign(CENTER);
  textFont(countdownFont);
  fill(10);
  stroke(0);
  text(String.valueOf(countdownSec), playfield.position.x, playfield.position.y+32);
}

void updatePlayfieldElements(){
  ball.move(playfield, playerOne, playerTwo);
  if(!playerTurn && botActive){ 
    playerTwo.moveKI(ball, playfield);
  }else if(playerTurn && botActive){
    playerTwo.moveKIidle(ball, playfield); 
  }
}

void displayPlayfieldElements(){
  playfield.display(playerOne, playerTwo);
  ball.display();
  playerOne.display();
  playerTwo.display();
}

void updateGoal(){
  if(ball.position.x < playfield.leftEdge()){  playfield.addScorePlayerTwo(); }
  if(ball.position.x > playfield.rightEdge()){ playfield.addScorePlayerOne(); }
  reset(false, true, true);
}

void reset(boolean resetScore, boolean resetBall, boolean resetPlayer){
  playActive  = false;
  if(resetScore){
    playfield.playerOneScore = 0;
    playfield.playerTwoScore = 0;
  }
  if(resetBall){
    ball = new Ball(playfield.position.x, playfield.position.y, ballSize, ballSpeed);
  }
  if(resetPlayer){
    playerOne.position.y = playfield.position.y;
    playerTwo.position.y = playfield.position.y;
  }
  playerTurn = false;
  activeState = GameState.START;
}

//Check for keyboard input from user
void keyPressed(){
  if(playActive){
    if(key == CODED){
      switch(keyCode){
        case UP:
          if(!botActive){ playerTwo.moveUp(ball, playfield); }
          break;
        case DOWN:
          if(!botActive){ playerTwo.moveDown(ball, playfield); }
          break;
      }
    }
    switch(key){
      case 'w':
        playerOne.moveUp(ball, playfield);
        break;
      case 's':
        playerOne.moveDown(ball, playfield);
        break;
      default:
        break;
    }
  }
  
  switch(key){
      case 'd':
        debugOn = !debugOn;
        break;
      case 'r':
        reset(true, true, true);
        break;
      case 'p':
        if(activeState != GameState.PAUSE && activeState == GameState.PLAY){
          playActive = false;
          activeState = GameState.PAUSE;
        }else if(activeState == GameState.PAUSE){
          activeState = GameState.START;
        }
        break;
      case 'm':
        reset(true, true, true);
        playerTurn = false;
        playActive = false;
        botActive  = true;
        activeState = GameState.MENU;
        break;
      default:
        break;
    }
}

//Check for mouse input from user
void mouseClicked(){
  switch(activeState){
    case MENU:
      if(mainMenu.botButton.mouseInside()){
        playerTwo.name = "BOT"; 
        activeState = GameState.START; 
      }
      if(mainMenu.pvpButton.mouseInside()){ 
        botActive = false;
        playerTwo.name = "Player 2";
        activeState = GameState.START;
      }
      break;
    case START:
      break;
    case PLAY:
      break;
    case GOAL:
      break;
    case PAUSE:
      break;
    default:
      break;
  }
}
