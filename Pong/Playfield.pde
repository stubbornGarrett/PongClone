class Playfield{
  PVector position;
  float hei, wid, borderThickness;
  int playerOneScore;
  int playerTwoScore;
  color fillColor, borderColor, lineColor;
  
  Playfield(float x, float y, float w, float h){
    position = new PVector(x, y);
    wid  = w; //height
    hei  = h; //width
    borderThickness = 10;
    playerOneScore = 0;
    playerTwoScore = 0;
    fillColor    = color( 20,  20,  20);
    borderColor  = color(200, 200, 200);
    lineColor    = color( 50, 200, 200);
  }
  
  void display(Player p1, Player p2){
    //Ground and Border Line
    strokeWeight(borderThickness);
    stroke(borderColor);
    fill(fillColor);
    rect(position.x-wid/2, position.y-hei/2, wid, hei);
    
    //Scoreboard
    textAlign(CENTER);
    textFont(scoreFont);
    fill(p1.fillColor);
    text(String.valueOf(playerOneScore), position.x-150, position.y-hei/3);
    text(p1.name, position.x-150, position.y-hei/3 + 40);
    
    textAlign(CENTER);
    textFont(scoreFont);
    fill(p2.fillColor);
    text(String.valueOf(playerTwoScore), position.x+150, position.y-hei/3);
    text(p2.name, position.x+150, position.y-hei/3 + 40);
    
    //Lines
    for(int i = 0; i < 15; i++){
      noStroke();
      fill(lineColor, 200-(200/15*i));
      rect(position.x-5-i, topEdge()   , 10+2*i, realHeight()/2-150);
      rect(position.x-5-i, position.y+150, 10+2*i, realHeight()/2-150);
      stroke(lineColor, 200-(200/15*i));
      noFill();
      circle(position.x, position.y, 300+i*2);
      circle(position.x, position.y, 300-i*2);
    }
    noStroke();
    fill(lineColor);
    rect(position.x-5, topEdge()     , 10, realHeight()/2-150);
    rect(position.x-5, position.y+150, 10, realHeight()/2-150);
    stroke(lineColor);
    noFill();
    circle(position.x, position.y, 300);
  }
  
  void addScorePlayerOne(){ playerOneScore += 1; }
  
  void addScorePlayerTwo(){ playerTwoScore += 1; }
  
  float topEdge(){    return position.y - hei/2 + borderThickness/2; }
  
  float bottomEdge(){ return position.y + hei/2 - borderThickness/2; }
  
  float leftEdge(){   return position.x - wid/2 + borderThickness/2; }
  
  float rightEdge(){  return position.x + wid/2 - borderThickness/2; }
  
  float realHeight(){ return bottomEdge() - topEdge(); }
  
  void displayEdges(){
    strokeWeight(1);
    stroke(0,255,0, 150);
    noFill();
    line(-width/2,    topEdge(),    width/2,     topEdge());
    line(-width/2,    bottomEdge(), width/2,     bottomEdge());
    line(rightEdge(), -height/2,    rightEdge(), height/2);
    line(leftEdge(),  -height/2,    leftEdge(),  height/2);
  }
}
