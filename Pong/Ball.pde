class Ball{
  PVector position, direction;
  ArrayList<PVector> history;
  float diameter, speed, outlineThickness;
  int bounceCount = 0;
  color fillColor, outlineColor;
  
  Ball(float x, float y, float d, float s){
    position  = new PVector(x, y);
    //if(random(0,1) < .5){
    //  direction = new PVector( random(0.5, 1), random(-1, 1));
    //}else{
    //  direction = new PVector(-random(0.5, 1), random(-1, 1));
    //}
    direction = new PVector( random(0.5, 1), random(0.3, 1));
    direction.normalize();
    diameter  = d;
    speed     = s;
    outlineThickness = 0;
    fillColor    = color(100, 250, 100);
    outlineColor = color(  0, 255, 0);
    history = new ArrayList<PVector>();
  }
  
  void display(){
    noStroke();
    for(int i = 0; i < history.size(); i++){
      fill(fillColor, 0+200/history.size()*i*0.6);
      circle(history.get(i).x, history.get(i).y, diameter+3);//-diameter-i
    }
    for(int i = 0; i < 5; i++){
      fill(fillColor, 200-35*i);
      circle(position.x, position.y, diameter+i*2);
    }
    strokeWeight(outlineThickness);
    stroke(outlineColor);
    fill(fillColor);
    circle(position.x, position.y, diameter);
  }
  
  void move(Playfield pf, Player pOne, Player pTwo){
    position.add(direction.mult(speed));
    direction.normalize();
    if(pf.topEdge() > topEdge() || pf.bottomEdge() < bottomEdge()){
      bounce(true, null);
    }
    if(checkCollision(pOne)){
      bounce(false, pOne);
      playerTurn = !playerTurn;
    }else if(checkCollision(pTwo)){
      bounce(false, pTwo);
      playerTurn = !playerTurn;
    }
    
    PVector v = new PVector(position.x, position.y);
    history.add(v);
    if(history.size() > 10){
      history.remove(0);
    }
  }
  
  void bounce(boolean horizontal, Player p){
    if(horizontal){
      direction.set( direction.x, -direction.y);
    }else{
      float mult = map(p.position.y - position.y, -((p.position.y+(p.hei/2)+(diameter/2))-p.position.y),  p.position.y-(p.position.y-(p.hei/2)-(diameter/2)), 0.9, 1.1); 
      direction.set(-direction.x,  direction.y*mult);
      direction.normalize();
      bounceCount++;
    }
    if(bounceCount%5 == 0){ speed += 1; }
  }
  
  boolean checkCollision(Player p){
    if(p.position.x < 0){
      if(p.rightEdge() >= leftEdge() && p.position.x <= position.x){
        if(p.bottomEdge() >= topEdge() && p.topEdge() <= bottomEdge()){
          return true;
        }
      }
    }else{
      if(p.leftEdge() <= rightEdge() && p.position.x >= position.x){
        if(p.bottomEdge() >= topEdge() && p.topEdge() <= bottomEdge()){
          return true;
        }
      }
    }
    return false;
  }
  
  float topEdge(){    return position.y - diameter/2 - outlineThickness/2; }
  
  float bottomEdge(){ return position.y + diameter/2 + outlineThickness/2; }
  
  float leftEdge(){   return position.x - diameter/2 - outlineThickness/2; }
  
  float rightEdge(){  return position.x + diameter/2 + outlineThickness/2; }
  
  void displayEdges(){
    strokeWeight(1);
    stroke(0,0,255, 150);
    noFill();
    line(-width/2,    topEdge(),    width/2,     topEdge());
    line(-width/2,    bottomEdge(), width/2,     bottomEdge());
    line(rightEdge(), -height/2,    rightEdge(), height/2);
    line(leftEdge(),  -height/2,    leftEdge(),  height/2);
  }
}
