float millis_to_drop = 5000.0;
float min_millis_per_bottle = 17;

class BottleDropper {
  PImage b_img;
  ArrayList<Bottle> bottles;
  int xpos;
  int ypos;
  int mywidth;
  int myheight;
  
  float millis_per_bottle = -1;
  float t_minus = -1;
  int num_dropped = 0;
  int num_to_drop = 0;
  boolean dropping = false;
  
  
  BottleDropper(PImage init_b_img,
                int init_xpos,
                int init_ypos,
                int init_width,
                int init_height){
    b_img = init_b_img;
    xpos = init_xpos;
    ypos = init_ypos;
    mywidth = init_width;
    myheight = init_height;
    bottles = new ArrayList<Bottle>();
  }
  
  void drop_n_bottles(int n){
    if (!dropping){
      millis_per_bottle = max(min_millis_per_bottle,millis_to_drop/n);
      num_to_drop = n;
      t_minus = 0;
      dropping = true;
    }
  }
  
  int get_num_dropped(){
    return num_dropped;
  }
  
  boolean is_dropping(){
    return dropping;
  }
  
  void draw(int dt){
    
    // if we aren't currently doing anything don't draw
    if (!dropping) {
      return;
    }
    
    // if we are dropping bottles, deal with dropping new ones
    // and if we're done, turn yourself off
    t_minus = t_minus - dt;
    while(t_minus < 0){
      if(num_dropped < num_to_drop){
        bottles.add(new Bottle(b_img,0,mywidth));
        num_dropped++;
        t_minus = t_minus + millis_per_bottle;
      } else if(bottles.size() == 0){
        t_minus = 0;
        num_dropped = 0;
        num_to_drop = 0;
        dropping = false;
      } else {
        break;
      }
    }
    
    // draw all the falling bottles
    pushMatrix();
    translate(xpos,ypos);
    for(int i = bottles.size()-1; i >= 0; i--){
      Bottle bottle = bottles.get(i);
      bottle.update(dt);
      if(bottle.dead()){
        bottles.remove(i);
      } else {
        bottle.draw();
      }
    }

    if (bottles.size() > 0){
      textAlign(CORNER);
      textSize(text_size);
      text("Number of bottles: " + num_dropped,text_size,myheight-text_size);
    }
    popMatrix();

  }
  
}