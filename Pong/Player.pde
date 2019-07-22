class Player{
  PVector position;
  float wid, hei, speed, outlineThickness;
  int ID;
  color fillColor, outlineColor;
  String name;
  
  Player(float x, float y, float w, float h, float s, int num, String txt){
    position = new PVector(x, y);
    wid  = w;
    hei  = h;
    speed = s;
    outlineThickness = 4;
    ID = num;
    if(ID == 1){
      fillColor    = color(255, 50,  50);
    }else{
      fillColor    = color( 50, 50, 255);
    }
    outlineColor = color(150, 255, 100);
    name = txt;
  }
  
  void display(){
    noStroke();
    for(int i = 0; i < 7; i++){
      fill(fillColor, 200-i*200/7);
      rect(position.x-wid/2-i, position.y-hei/2-i, wid+i*2, hei+i*2);
    }
    //stroke(outlineColor);
    fill(fillColor);
    rect(position.x-wid/2, position.y-hei/2, wid, hei);
  }
  
  void moveUp(Ball b, Playfield pf){
    if(pf.topEdge()+speed <= topEdge()){
      position.y -= speed;
    }
  }
  
  void moveDown(Ball b, Playfield pf){
    if(pf.bottomEdge()-speed >= bottomEdge()){
      position.y += speed;
    }
  }
  
  void moveKI(Ball b, Playfield pf){
    if(pf.topEdge()+speed <= topEdge() && b.rightEdge() < position.x){
      if(b.position.y < position.y-hei/2){
        position.y -= speed;
      }
    }
    if(pf.bottomEdge()-speed > bottomEdge() && b.rightEdge() < position.x){
      if(b.position.y >= position.y+hei/2){
        position.y += speed;
      }
    }
  }
  
  void moveKIidle(Ball b, Playfield pf){
    if(random(0, 1) < 0.02){
      moveUp(b, pf);
    }else if(random(0, 1) < 0.02){
      moveDown(b, pf);
    }
  }
  
  float topEdge(){    return position.y - hei/2 - outlineThickness/2; }
  
  float bottomEdge(){ return position.y + hei/2 + outlineThickness/2; }
  
  float leftEdge(){   return position.x - wid/2 - outlineThickness/2; }
  
  float rightEdge(){  return position.x + wid/2 + outlineThickness/2; }
  
  void displayEdges(){
    strokeWeight(1);
    stroke(255,0,0, 150);
    noFill();
    line(-width/2, topEdge(), width/2, topEdge());
    line(-width/2, bottomEdge(), width/2, bottomEdge());
    line(rightEdge(), -height/2, rightEdge(), height/2);
    line(leftEdge(), -height/2, leftEdge(), height/2);
  }
}
