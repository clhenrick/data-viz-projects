class Label {

  Label(String txt, float x, float y) {
    // get text width
//    textAlign(RIGHT);
    float w = textWidth(txt) - 230;

    // check for viz bounds
    if (x + w + rightMargin + 20 > width) {
//      textAlign(LEFT);
      x -= w + 20;
    }

    // draw background
    fill(255);
    noStroke();
    rectMode(CORNER);
    rect(x+10, y-30, w + 10, 20);

    // draw text
    PFont f = createFont("Frutiger LT Std 65 Bold", 12);
    textFont(f);
    fill(0);
    text(txt, x+15, y-15);
  }
}

