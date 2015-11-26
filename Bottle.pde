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
  
  Bottle(PImage init_img, float init_yspeed, float init_rotspeed, float init_angle) {
    xpos = random(width);
    ypos = -1*b_height;
    yspeed = init_yspeed;
    rotspeed = init_rotspeed;
    angle = init_angle;
    img = init_img;
  }
  
  Bottle(PImage init_img) {
    this(init_img, random(0.05,0.2), random(0.0005,0.002), random(TAU));
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
    