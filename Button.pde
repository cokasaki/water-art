int side = 50;

class Button {
  
  int xpos;
  int ypos;
  
  Button(int x, int y){
    xpos = x;
    ypos = y;
  }
  
  void draw(){
    noFill();
    rectMode(CORNER);
    rect(xpos,ypos,side,side);
  }
  
  boolean inside(int x,int y){
    return xpos <= x && 
           x <= (xpos + side) && 
           ypos <= y && 
           y <= (ypos + side);
  }
  
}