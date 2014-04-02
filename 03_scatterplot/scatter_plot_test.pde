// Parsons data viz midterm scatterplot test
// chris henrick, spring 2014
// TO DO: 
// clean up data! remove rows for regions & filter for null values.
// implement OOP with Bubble and Label objects
// add mouse interactivity

String file1 = "co2-kt-by-country_2010.csv";
String file2 = "GNI_per-country_2012.csv";
String file3 = "pop_total_2012.csv";

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

int minRadius = 10;
int maxRadius = 50;

color c;

PVector[] positions = new PVector[252];

void setup() {
  size(1000, 600);
  graphHeight = height - topMargin - bottomMargin;
  graphWidth = width - leftMargin - rightMargin;
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
  println(co2Min, co2Max, gniMin, gniMax, popMin, popMax);

  float xPos, yPos, radius; 

  for (int i=0; i<positions.length; i++) {

    float mapY = map(co2[i], co2Min, co2Max, 0, graphHeight);
    yPos = height - topMargin - mapY;

    float mapX = map(gni[i], gniMin, gniMax, 0, graphWidth);
    xPos = leftMargin + mapX;

    radius = map(pop[i], popMin, popMax, minRadius, maxRadius);

    noStroke();    
    positions[i] = new PVector(xPos, yPos);

    fill(255);
    ellipse(positions[i].x, positions[i].y, radius, radius);
  }
}

void parseData() {
  // steps: 
  // 1. find common countries in all 3 datasets
  // 2. only use data from these countries to map to viz
  // 3. use each data set for one of three values

  for (int j=1; j<rawData1.length; j++) {
    String[] thisRow = split(rawData1[j], ",");
    names[j-1] = thisRow[0];
    if (int(thisRow[2]) != 0) {
      co2[j-1] = int(thisRow[2]);
    }
  }

  for (int k=1; k<rawData2.length; k++) {
    //printArray(rawData2);
    String[] thisRow = split(rawData2[k], ",");
    gni[k-1] = int(thisRow[3]);
  }

  for (int m=1; m<rawData3.length; m++) {
    String[] thisRow = split(rawData3[m], ",");
    pop[m-1] = int(thisRow[2]);
  }
} // end parseData

