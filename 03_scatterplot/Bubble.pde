class Bubble {
  String name; //name of country
  int xValue; // value for x-axis
  int yValue; // value for y-axis
  float r; // radius for size of bubble
  color c; // color of bubble (TBD...)
  PVector pos; // PVector to store x y coordinates
  
  
  // Bubble constructor
  Bubble(float x_, float y_, float r_, color c_){
    pos.x = x_;
    pos.y = y_;
    r = r_;
    c = c_;
  }
  
  void display(){
    // check for mouseover
    if (dist(mouseX, mouseY, pos.x, pos.y) <= r) {
      fill(0);
    } else {
      fill(c);
    }
    noStroke();
    ellipse(pos.x, pos.y, r, r);
  }
  
//  void displayLabel(){
//    if (dist(mouseX, mouseY, posX, posY) <= r) {
//      String txt = "test";
//      Label label = new Label(txt, mouseX, mouseY);
//    }
//  }
  
}
