class Plot {
  Point2D topLeft, bottomRight;
  PVector topL, bottomR;
  int marginW = 100;
  int marginH = 100;
  color c;
  float xSpacer, ySpacer;
  String xLabel, yLabel;
  float xMin, xMax, yMin, yMax;
  boolean selected;

  Plot(int x1_, int y1_, int x2_, int y2_, color c_) {
    topLeft = new Point2D(x1_, y1_);
    bottomRight = new Point2D(x2_, y2_);
    c = c_;
  }

  void display() {
    fill(c);
    noStroke();
    rectMode(CORNERS);
    rect(topLeft.x, topLeft.y, bottomRight.x, bottomRight.y);
  }

  void gui(String xLabel_, String yLabel_, float xMin_, float xMax_, float yMin_, float yMax_) {
    xLabel = xLabel_;
    yLabel = yLabel_;
    xMin = xMin_;
    yMin = yMin_;
    xMax = xMax_;
    yMax = yMax_;
    
    xSpacer = w()/9;
    ySpacer = h()/9;
    //println("w: " + w() + " w/10: " + w()/10);
    
    //ticks and labels for x-axis
    for (int i = 0; i<=w(); i += xSpacer) {
      float xPos = (topLeft.x + marginW/2) + i;
      stroke(100);
      line(xPos, bottomRight.y - marginH/2 + 5, xPos, bottomRight.y - marginH/2 + 15);
      float xScale = map(xPos, topLeft.x + marginW/2, bottomRight.x - marginW/2 -2, xMin, xMax);
      fill(255);
      float w = textWidth(nf(xScale, 1, 2));
      text(nf(xScale, 1, 2), xPos - w/2, bottomRight.y - marginH/2 + 30);
    }
    
    // title label for x-axis
    float xLabelWidth = textWidth(xLabel);
    text(xLabel, marginW/2 + w()/2 - xLabelWidth/2, bottomRight.y - marginH/2 + 45);
    
    // ticks and values for y axis
    for (int y = 0; y<=h(); y += ySpacer) {
      float yPos = (bottomRight.y - marginH/2) - y;
      stroke(100);
      line(topLeft.x + marginW/2 -5, yPos, topLeft.x + marginW/2 - 15, yPos); //topLeft.x + marginW/2 - 5
      float yScale = map(yPos, bottomRight.y - marginH/2, topLeft.y + marginH/2 +2, yMin, yMax);
      fill(255);
      text(nf(yScale, 1, 2), topLeft.x + 3, yPos+4);
    }
    
    //title label for y axis    
    float yLabelWidth = textWidth(yLabel);
    pushMatrix();
    translate(topLeft.x + 15, h()/2 + yLabelWidth);
    rotate (PI/2);
    fill(0);
    text(yLabel, -yLabelWidth, 30);
    rotate (-PI);
    popMatrix();
    
    // lines for x and y axises for debugging
    stroke(100);
    strokeWeight(1);
    line(topLeft.x + marginW/2, bottomRight.y - marginH/2, bottomRight.x - marginW/2 - 2, bottomRight.y - marginH/2);
    line(topLeft.x + marginW/2, bottomRight.y - marginH/2, topLeft.x + marginW/2, topLeft.y + marginH/2 + 2);
  }

  Point2D topLeft() {
    return topLeft;
  }

  Point2D bottomRight() {
    return bottomRight;
  }

  float w() {
    return bottomRight.x - topLeft.x - marginW;
  }

  float h() {
    return bottomRight.y - topLeft.y - marginH;
  }
}

