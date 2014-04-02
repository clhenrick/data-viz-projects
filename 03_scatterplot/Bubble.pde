class Bubble {
  String name; //name of country
  int xValue; // value for x-axis
  int yValue; // value for y-axis
  float r; // radius for size of bubble
  color c; // color of bubble (TBD...)
  PVector pos; // PVector to store x y coordinates


    // Bubble constructor
  Bubble(float x_, float y_, float r_, color c_) {
    pos.x = x_;
    pos.y = y_;
    r = r_;
    c = c_;
  }


  void display() {
    // check for mouseover
    if (dist(mouseX, mouseY, pos.x, pos.y) <= r) {
      fill(255);
    } 
    else {
      fill(c);
    }
    noStroke();
    ellipse(pos.x, pos.y, r, r);
  }

  void displayLabel() {
    // check for mouse hover to add text
    if (dist(mouseX, mouseY, pos.x, pos.y) < r) { 

      String txt = "Name: " + name + " GNI: " + xValue + " CO2 kt: " + yValue + " Pop: " + r; 
      float textW = textWidth(txt);
      float x, y;
      y = mouseY;
      x = mouseX;

      // if the text is too close to the edge move it over 
      if (mouseX + textW + rightMargin > width) {
        x -= textW + rightMargin;
      } 
      else {
        x = mouseX;
      }
      fill(255, 0, 0);
      noStroke();
      text(txt, x, y);
    }
  }

  //  void displayLabel(){
  //    if (dist(mouseX, mouseY, posX, posY) <= r) {
  //      String txt = "test";
  //      Label label = new Label(txt, mouseX, mouseY);
  //    }
  //  }
}

