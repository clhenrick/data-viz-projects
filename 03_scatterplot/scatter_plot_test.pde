// Parsons data viz midterm scatterplot test
// chris henrick, spring 2014
// Code used in this sketch has been reused and altered from: http://www.openprocessing.org/sketch/51382
// color palette from ColorBrewer2.org

import controlP5.*;
ControlP5 cp5;

String dataFile = "combined_data_simp2.csv";
String regionsFile = "regions.csv";

String[] rawData;
String[] regionStyleData;
String[] names = new String[187];
String[] regions = new String[187];
float[] co2 = new float[187];
float[] co2_pc = new float[187];
float[] gni = new float[187];
float[] gni_pc = new float[187];
int[] pop = new int[187];
int  popMin, popMax;
float co2Min, co2Max, gniMin, gniMax, co2_pcMin, co2_pcMax, gni_pcMin, gni_pcMax;

ArrayList<Bubble> allBubbles = new ArrayList<Bubble>();
ArrayList<Bubble> moreBubbles = new ArrayList<Bubble>();
ArrayList<Region> allRegions = new ArrayList<Region>();

int leftMargin = 50;
int rightMargin = 50;
int topMargin = 75;
int bottomMargin = 120;
int graphHeight, graphWidth;
int minRadius = 6;
int maxRadius = 100;

String xCountryLabel = "Gross-National-Income (millions of U.S. dollars, scaled logarithmically)";
String yCountryLabel = "CO2 output (kilotons per country, scaled logarithmically)";
String xPerCapitaLabel = "Per-Capita Gross-National-Income (U.S. dollars, scaled logarithmically)";
String yPerCapitaLabel = "Per-Capita CO2 output (metric tons, scaled logarithmically)";

Plot countryLevel;
Plot perCapita;

boolean flag;

void setup() {
  //colorMode(HSB, 360, 100, 100, 255);
  //colorMode(RGB, 255, 255, 255, 255);
  size(1300, 900);
  countryLevel = new Plot(leftMargin, topMargin, width - rightMargin, height - bottomMargin, color(50));
  perCapita = new Plot(leftMargin, topMargin, width - rightMargin, height - bottomMargin, color(50));
  graphHeight = height - topMargin - bottomMargin;
  graphWidth = width - leftMargin - rightMargin;
  rawData = loadStrings(dataFile); 
  regionStyleData = loadStrings(regionsFile); 
  parseData();
  
  cp5 = new ControlP5(this);
  cp5.addToggle("Toggle View")
     .setValue(0)
     .setPosition(width-rightMargin+100, 30)
     .setSize(100,20)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     ;
}

void draw() {
  background(255, 255, 255);
  smooth();
  
  if(flag==true){
    drawGraph(countryLevel);
  } else {
    drawGraph(perCapita);
  }

// country level data renders
//  countryLevel.display();
//  countryLevel.gui(xCountryLabel, yCountryLabel, gniMin, gniMax, co2Min, co2Max);
//  render(allBubbles, gniMin, gniMax, co2Min, co2Max, countryLevel);

  // per capita data renders
  perCapita.display();
  perCapita.gui(xPerCapitaLabel, yPerCapitaLabel, gni_pcMin, gni_pcMax, co2_pcMin, co2_pcMax);
  render(moreBubbles, gni_pcMin, gni_pcMax, co2_pcMin, co2_pcMax, perCapita);  

  drawTitle();
  drawLegend();
}

void drawGraph(Plot plot) {
  plot.display();
  plot.gui();
  render();
}


void mouseReleased() {
  println("mouse click");
  String link1 = "http://www.openprocessing.org/sketch/51382";
  String link2 = "http://data.worldbank.org/indicator";
  String link3 = "http://colorbrewer2.org/";
  
  //if (dist(mouseX, 
  
  
}

void keyPressed() {
  println("key pressed");
}

void buttons() {
  float thirdW = graphWidth/3;
  
  pushMatrix();
  translate(leftMargin + (2*thirdW), 25);
  
  String toggle = "Toggle view:";
  float toggleW = textWidth(toggle);
  text(toggle, thirdW - 110 - toggleW, 20);
  
  rectMode(CORNERS);
  fill(255,0,0);
  rect(thirdW-100,0,thirdW,30);
  fill(255);
  String plot1 = "Country-Level";
  String plot2 = "Per-Capita Data";
  text(plot1, thirdW - 93, 20);
  
  popMatrix();
}

void render(ArrayList<Bubble> someBubbles, float xMin, float xMax, float yMin, float yMax, Plot dataPlot) {
  for (int i = someBubbles.size()-1; i>=0; i --) {
    Bubble b = someBubbles.get(i);
    b.display(xMin, xMax, yMin, yMax, dataPlot);
    //println(b);
  }
  for (int i = someBubbles.size()-1; i>=0; i --) {
    Bubble b = someBubbles.get(i);
    b.displayLabel();
  }
}

void drawTitle() {
  int xPos, yPos;
  String title = "Global CO2 Output and Income";
  float titleWidth = textWidth(title);
  fill(0);
  text(title, width/2 - titleWidth/2, 50);
}

void drawLegend() {
  //set up
  int xMargin = 10;
  int yMargin = 10;  
  int legendWidth = graphWidth - (xMargin * 2);
  int legendHeight = bottomMargin - (yMargin * 2);

  String regionExp = "Color represents a country's region";
  float regionExpL = textWidth(regionExp);
  int numRegions = 7;
  String[] regions = {
    "East Asia & Pacific", "Europe & Central Asia", "Latin America & Caribbean", "Middle East & North Africa", "North America", "South Asia", "Sub-Saharan Africa"
  };
  float xSpacer = graphWidth/numRegions;
  int ySpacer = 20;
  
  //translate to area below graph
  pushMatrix();
  translate(leftMargin, graphHeight + topMargin);
//  rectMode(CORNERS);
//  noStroke();
//  fill(200);
//  rect(0, 0, graphWidth, bottomMargin);
  
  // translate to areas with margins
  pushMatrix();
  translate(xMargin, yMargin);

  fill(255);
  rect(0, 0, legendWidth, legendHeight);

  fill(0);
  text(regionExp, legendWidth/3-regionExpL*1.5, 12);

  // region color key
  int r, g, b;
  String regionLabel;
  for (int i=0; i<numRegions; i++) {
    for (int k=allRegions.size()-1; k >=0; k--) {
      Region thisR = allRegions.get(k);
      if (k == i) {
        r = int(thisR.rValue());
        g = int(thisR.gValue());
        b = int(thisR.bValue());
        regionLabel = thisR.nameValue();
        fill(r, g, b, 175);
        if (i<4) {
          stroke(150);
          ellipse(10, 25 + (ySpacer * i), 10, 10);
          fill(0);
          noStroke();
          text(regionLabel, 25, 30 + (ySpacer * i));
          break;
        } 
        else if (i >=4) {
          stroke(150);
          ellipse(205, 10 + (ySpacer * (i-3)), 10, 10);
          fill(0);
          noStroke();
          text(regionLabel, 225, 15 + (ySpacer * (i-3)));  
          break;
        }
      }
    }
  }

  // diagram for population size
  // translate to 2/3 over 
  float thirdLW = legendWidth/3;
  pushMatrix();
  translate(thirdLW, 0);
  //  fill(255,0,0,50);
  //  rect(0,0,thirdLW, 100);

  String popTitle = "Circle size is proportional to population";
  fill(0);  
  text(popTitle, 10, 12);
  fill(175);
  ellipse(thirdLW/4, 50, minRadius, minRadius);
  fill(0);
  String labelMin = "20,470\npeople\n(min)";
  textAlign(CENTER, CENTER);
  text(labelMin, 55, 53);

  fill(175);
  ellipse(thirdLW/4 * 3, 50, maxRadius, maxRadius);
  fill(0);
  String labelMax = "1.34 billion\npeople\n(max)";
  textAlign(CENTER, CENTER);
  text(labelMax, thirdLW/2, 53);  
  popMatrix();

  textAlign(LEFT);

  // create credits for data-source, color brewer
  // translate to right third of legend area
  float rightSide = legendWidth - thirdLW;  
  pushMatrix();
  translate(rightSide, 0);

  String labelCredits = "Credits:";
  String worldBank = "* Data sourced from World Bank Data Indicators for the year 2010.";
  String colorBrewer = "* Color scheme from ColorBrewer2.org";
  String codeReuse = "* Some code was reused from \nhttp://www.openprocessing.org/sketch/51382";
  text(labelCredits, 10, 12);
  text(worldBank, 10, 32);
  text(colorBrewer, 10, 52);
  text(codeReuse, 10, 72);
  popMatrix();

  // create pop-up for data corrections / fill-ins

  // provide explanation of logarithms?
  popMatrix();
  popMatrix();
}

void setMinMax() {
  co2Min = min(co2);
  co2Max = max(co2);
  gniMin = min(gni);
  gniMax = max(gni);
  popMin = min(pop);
  popMax = max(pop);
  co2_pcMin = min(co2_pc);
  co2_pcMax = max(co2_pc);
  gni_pcMin = min(gni_pc);
  gni_pcMax = max(gni_pc);
  println(co2_pcMin, co2_pcMax); //co2Min, co2Max, popMin, popMax, gniMin, gniMax, 
}

void parseData() {
  String[] regionsWB = { 
    "East Asia & Pacific", "Europe & Central Asia", "Latin America & Caribbean", "Middle East & North Africa", "North America", "South Asia", "Sub-Saharan Africa"
  };

  println("rawData.length: " + rawData.length);
  for (int i=1; i<rawData.length; i++) {
    String[] thisRow = split(rawData[i], ",");
    //printArray(rawData);
    names[i-1] = thisRow[0];
    regions[i-1] = thisRow[6];
    gni[i-1] = log(float(thisRow[1]));
    gni_pc[i-1] = log(float(thisRow[4]));
    co2[i-1] = log(float(thisRow[2]));
    co2_pc[i-1] = log(float(thisRow[5]));
    pop[i-1] = int(thisRow[3]);

    String region = thisRow[6];

    for (int j = 1; j<regionStyleData.length; j++) {
      String[] thisRegion = split(regionStyleData[j], ",");
      //printArray(thisRegion);
      //println(thisRegion[0]);

      Region countryRegion = new Region(thisRegion[0], int(thisRegion[1]), int(thisRegion[2]), int(thisRegion[3]));
      allRegions.add(countryRegion);
    }

    int r, g, b;

    for (int k = allRegions.size()-1; k >= 0; k--) {
      Region thisR = allRegions.get(k);
      println(thisR.nameValue());

      if (thisRow[6].equals(thisR.nameValue())) {
        r = int(thisR.rValue());
        g = int(thisR.gValue());
        b = int(thisR.bValue());

        Bubble bubble = new Bubble(thisRow[0], thisRow[6], log(float(thisRow[1])), log(float(thisRow[2])), int(thisRow[3]), r, g, b);
        Bubble second = new Bubble(thisRow[0], thisRow[6], log(float(thisRow[4])), log(float(thisRow[5])), int(thisRow[3]), r, g, b);
        allBubbles.add(bubble);
        moreBubbles.add(second);
        break;
      }
    }
    println("bubble size: " + allBubbles.size() + " morebubbles size: " + moreBubbles.size());
  }
  setMinMax();
}

