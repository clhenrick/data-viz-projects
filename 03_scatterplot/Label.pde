class Label {
  
  Label(String txt, float x, float y) {
    // get text width
    float w = textWidth(txt);
    
    // check for viz bounds
    if (x + w + 20 > width) {
      x -= w + 20;
    }
    
    // draw background
    fill(255);
    noStroke();
    rectMode(CORNER);
    rect(x+10, y-30, w + 10, 20);
    
    // draw text
    fill(0);
    text(txt, x+15, y-15);
  }
}

