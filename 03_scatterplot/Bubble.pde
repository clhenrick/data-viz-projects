class Bubble {
  String name; //name of country
  String region; // region of country according to WB
  int radius; // radius for size of bubble
  float size;
  color c; // color of bubble (TBD...)
  int r, g, b, alpha;
  float x, y;
  float xPos, yPos;
  PVector pos;
  float xMin, xMax, yMin, yMax;
  Plot dataPlot;


  // Bubble constructor
  Bubble(String name_, String region_, float x_, float y_, int pop_, int r_, int g_, int b_ ) {
    name = name_;
    region = region_;
    x = x_;
    y = y_;
    radius = pop_;
    //c = c_;
    r = r_;
    g = g_;
    b = b_;
  }

  void display(float xMin_, float xMax_, float yMin_, float yMax_, Plot dataPlot_) {
    xMin = xMin_;
    yMin = yMin_;
    xMax = xMax_;
    yMax = yMax_;
    dataPlot = dataPlot_;
    
    float mapY = map(y, yMin, yMax, 0, dataPlot.h());
    yPos = height - 170 - mapY;

    float mapX = map(x, xMin, xMax, 0, dataPlot.w());
    xPos = 100 + mapX;

    size = map(radius, popMin, popMax, minRadius, maxRadius);
    
    alpha = 175;

    // check for mouseover
    if (dist(mouseX, mouseY, xPos, yPos) <= size/2 ) {
      strokeWeight(1);
      stroke(255,alpha);
      fill(r, g, b, 255);      
    } 
    else {
      noStroke();
      fill(r, g, b, alpha);
    }
    ellipse(xPos, yPos, size, size);
  }

  void displayLabel() {
    // check for mouse hover to add text
    if (dist(mouseX, mouseY, xPos, yPos) < size/2) { 

      String txt = name + " | Region: " + region + " | GNI: " + x + " | CO2 kt: " + y + " | Pop: " + radius;
      Label label = new Label(txt, mouseX, mouseY);
    }
  }
}

