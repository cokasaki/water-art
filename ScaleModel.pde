int liters_per_person = 80; // ???
int b_w_per_person = 10; // ???

float b_ratio = 304.0/97.0;
float p_ratio = 223.0/97.0;

class ScaleModel {
  PImage bottle_img;
  PImage person_img;
  int margin;
  int xpos;
  int ypos;
  int mywidth;
  int myheight;
  
  ScaleModel(PImage init_b_img,
             PImage init_p_img,
             int init_x,int init_y,
             int init_w,int init_h,
             int init_margin) {
  bottle_img = init_b_img;
  person_img = init_p_img;
  xpos = init_x;
  ypos = init_y;
  mywidth = init_w;
  myheight = init_h;
  margin = init_margin;
  }
  
  void draw(int dt,int n){
    
    // don't draw anything if there aren't bottles to visualize
    if (n <= 0){
      return;
    }
    
    pushMatrix();
    translate(xpos,ypos);
    float b_bottle_scale = pow(n, 1/3.0);
    float width_vs_person = b_bottle_scale/b_w_per_person;
    float person_width = (mywidth-3*margin)/(1+width_vs_person);
    float b_bottle_width = (mywidth-3*margin)-person_width;
    float b_bottle_height = b_ratio*b_bottle_width;
    float person_height = p_ratio*person_width;
  
    imageMode(CORNER);
    image(person_img,margin,myheight-margin-person_height,person_width,person_height);
    image(bottle_img,2*margin+person_width,myheight-margin-b_bottle_height, b_bottle_width,b_bottle_height);
    popMatrix();
    
  }
}