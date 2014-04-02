// Parsons data viz midterm scatterplot test
// chris henrick, spring 2014
// TO DO: 
// clean up data! remove rows for regions & filter for null values.
// implement OOP with Bubble and Label objects
// add mouse interactivity

String file = "combined_data_simp.csv";

String file1 = "co2-kt-by-country_2010.csv";
String file2 = "GNI_per-country_2012.csv";
String file3 = "pop_total_2012.csv";
String[] rawData;
String[] rawData1;
String[] rawData2;
String[] rawData3;

String[] names = new String[252];
int[] co2 = new int[252];
int[] gni = new int[252];
int[] pop = new int[252];

ArrayList<Bubble> allBubbles = new ArrayList<Bubble>();


int leftMargin = 50;
int rightMargin = 50;
int topMargin = 100;
int bottomMargin = 100;

int graphHeight, graphWidth;

int minRadius = 2;
int maxRadius = 100;

color c;
  
PVector[] positions = new PVector[252];

void setup() {
  size(1000, 600);
  graphHeight = height - topMargin - bottomMargin;
  graphWidth = width - leftMargin - rightMargin;
  rawData = loadStrings(file);
  rawData1 = loadStrings(file1);
  rawData2 = loadStrings(file2);
  rawData3 = loadStrings(file3);  
  parseData();
}

void draw() {
  background(30);
  display();
}

void keyPressed() {
  println("key pressed");
}

void display() {
  int co2Min, co2Max, gniMin, gniMax, popMin, popMax;

  co2Min = min(co2);
  co2Max = max(co2);
  gniMin = min(gni);
  gniMax = max(gni);
  popMin = min(pop);
  popMax = max(pop);
  //println(co2Min, co2Max, gniMin, gniMax, popMin, popMax);

  float xPos, yPos, radius; 

  for (int i=0; i<positions.length; i++) {

    float mapY = map(co2[i], co2Min, co2Max, 0, graphHeight);
    yPos = height - topMargin - mapY;

    float mapX = map(gni[i], gniMin, gniMax, 0, graphWidth);
    xPos = leftMargin + mapX;

    radius = map(pop[i], popMin, popMax, minRadius, maxRadius);

    noStroke();    
    positions[i] = new PVector(xPos, yPos);

    fill(100);
    
    // check for mouse hover to highlight circle
    if (dist(mouseX, mouseY, positions[i].x, positions[i].y) < radius) {
      fill(255);
      println(radius);
    }
    ellipse(positions[i].x, positions[i].y, radius, radius);

    // check for mouse hover to add text
    if (dist(mouseX, mouseY, positions[i].x, positions[i].y) < radius) { 

      String txt = "Name: " + names[i] + " GNI: " + gni[i] + " CO2 kt: " + co2[i] + " Pop: " + pop[i]; 
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
}

void parseData() {
  for (int i=1; i<rawData.length; i++) {
    String[] thisRow = split(rawData[i], ",");
    //printArray(rawData);
    names[i-1] = thisRow[0];
    gni[i-1] = int(thisRow[1]);
    co2[i-1] = int(thisRow[2]);
    pop[i-1] = int(thisRow[3]);
    //printArray(names[i-1]);
  }
} 
