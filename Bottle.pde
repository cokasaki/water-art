// constants controlling the size of the falling bottles
int b_scale = 5;
float b_width = 97.0/b_scale;
float b_height = 304.0/b_scale;

class Bottle {
  float xpos;
  float ypos;
  float angle;
  PImage img;
  
  // in (pixels?) per millisecond
  float yspeed;
  // in radians per millisecond
  float rotspeed;
  
  Bottle(PImage init_img, float init_xpos, float init_yspeed, float init_rotspeed, float init_angle) {
    xpos = init_xpos;
    ypos = -1*b_height;
    yspeed = init_yspeed;
    rotspeed = init_rotspeed;
    angle = init_angle;
    img = init_img;
  }
  
  Bottle(PImage init_img, int left, int right) {
    this(init_img, random(left+b_height,right-b_height),random(0.1,0.2), random(0.0005,0.002), random(TAU));
    
    if (random(1) > 0.5) {
      rotspeed = -1*rotspeed;
    }
  }  
  
  void update(float dt) {
    ypos = ypos+yspeed*dt;
    angle = angle+rotspeed*dt;
  }
  
  void draw() {
    pushMatrix();
    
    translate(xpos,ypos);
    rotate(angle);
    
    imageMode(CENTER);
    image(img,0,0,b_width,b_height);
    
    popMatrix();
  }
  
  boolean dead() {
    return (ypos > height + b_height);
  }
  
  
}
    