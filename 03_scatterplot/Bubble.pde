class Bubble {
  float posX, posY, r;
  color c;
  String[] name = new String[253];
  // Bubble constructor
  Bubble(float _x, float _y, float _r, color _c){
    posX = _x;
    posY = _y;
    c = _c;
    r = _r;
  }
  
  void display(){
    // check for mouseover
    if (dist(mouseX, mouseY, posX, posY) <= r) {
      fill(0);
    } else {
      fill(c);
    }
    noStroke();
    ellipse(posX, posY, r, r);    
  }
  
  void displayLabel(){
    if (dist(mouseX, mouseY, posX, posY) <= r) {
      String txt = "test";
      Label label = new Label(txt, mouseX, mouseY);
    }
  }
  
}
