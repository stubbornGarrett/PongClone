class MainMenu{
  Button botButton, pvpButton;
  color botBtnActiveCol, botBtnIdleCol, pvpBtnActiveCol, pvpBtnIdleCol;
  
  MainMenu(){
    botBtnActiveCol = color(200, 250, 200);
    botBtnIdleCol   = color(150, 200, 150);
    pvpBtnActiveCol = color(250, 200, 200);
    pvpBtnIdleCol   = color(200, 150, 150);
    botButton = new Button(-180, -50, 300, 100, "P1 vs BOT");
    pvpButton = new Button( 180, -50, 300, 100, "P1 vs P2");
    pvpButton.setColor(0, color(0), color(200, 150, 150), color(0));
  }
  
  void display(){
    if(botButton.mouseInside()){
      botButton.setColor(0, color(0), botBtnActiveCol, color(0));
    }else{
      botButton.setColor(0, color(0), botBtnIdleCol, color(0));
    }
    if(pvpButton.mouseInside()){
      pvpButton.setColor(0, color(0), pvpBtnActiveCol, color(0));
    }else{
      pvpButton.setColor(0, color(0), pvpBtnIdleCol, color(0));
    }
    
    background(color(30));
    botButton.display();
    pvpButton.display();
    
    //Control Symbols
    textFont(countdownFont);
    textAlign(CENTER);
    fill(200);
    noStroke();
    text("Pong Clone", 0, -250);
    textFont(controlFont);
    text("in Processing", 0, -200);
    fill(255);
    text("CONTROLS", 0, 80);
    text("Player 1: W  +  S  ", 0, 110);
    text("Player 2: UP + DOWN", 0, 135);
    text("Menu:    M", 0, 200);
    text("Pause:   P", 0, 230);
    text("Restart: R", 0, 260);
    fill(110);
    text("Debug On/Off: D", 0, 320);
  }
}
