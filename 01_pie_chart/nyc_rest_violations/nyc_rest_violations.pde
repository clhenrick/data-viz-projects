// what: nyc food violation data; January-February, 2014 
// by: chris henrick
// date: feb 28, 2014
// data courtesy of: NYC OpenData & 311
// data source: https://data.cityofnewyork.us/Health/Restaurant-Inspection-Results/4vkw-7nck
// data retrieved: 2/28/14
// to do: normalize data by finding # of total restaurants per borough
//        add title and key or interactivity

String filename = "nyc_rest_viol_subset.csv";
String[] rawData;

int MHTNtotal, BKtotal, QNStotal, BNXtotal, SItotal, Gtotal, errorTotal;
float MHTNpos, BKpos, QNSpos, BNXpos, SIpos;
color MHTN, BK, BNX, QNS, SI;
String min, max;

void setup() {
  size(500, 500);
  rawData = loadStrings(filename);
  MHTN = color(215,25,28);
  SI = color(255,255,191);
  BNX = color(253,174,97);
  QNS = color(171,217,233);
  BK = color(44,123,182);
  checkData();
}

void draw() {
  background(40);
  noStroke();
  textSize(20);
  
  float startPos = radians(200);
  float currPos = startPos;
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(currPos);
  fill(MHTN);
  arc(0,0,400,400,0,MHTNpos);
  currPos = MHTNpos;
  fill(0);
  //text("MHTN", 50, 50);
  
  rotate(currPos);
  fill(BNX);
  arc(0,0,400,400,0,BNXpos);
  currPos = BNXpos;

  rotate(currPos);
  fill(BK);
  arc(0,0,400,400,0,BKpos);
  currPos = BKpos;

  rotate(currPos);
  fill(QNS);
  arc(0,0,400,400,0,QNSpos);
  currPos = QNSpos;

  rotate(currPos);
  fill(SI);
  arc(0,0,400,400,0,SIpos);
  
  fill(40);
  ellipse(0,0,250,250);
  
  popMatrix();
  
}

void checkData(){
  for(int i=1; i<rawData.length; i++){
    String[] thisRow = split(rawData[i], ",");
   // printArray(thisRow);
    
    if (thisRow[1].contains("1")){
      MHTNtotal += 1;
    } else if (thisRow[1].contains("2")){
      BNXtotal += 1;
    } else if (thisRow[1].contains("3")){
      BKtotal += 1;
    } else if (thisRow[1].contains("4")){
      QNStotal += 1;
    } else if (thisRow[1].contains("5")){
      SItotal += 1;
    } else {
      println("Error: index = " + i + " ");
      printArray(thisRow);
      errorTotal += 1;
    }
  }
  
  Gtotal = MHTNtotal + BNXtotal + BKtotal + QNStotal +SItotal;
  println("manhattan total: " + MHTNtotal);
  println("bronx total: " + BNXtotal);
  println("brooklyn total: " + BKtotal);
  println("queens total: " + QNStotal);
  println("staten island total: " + SItotal);
  println("grand total: " + Gtotal);  
  println("data error total: " + errorTotal);
  
  MHTNpos = calcRadians(MHTNtotal);
  BNXpos = calcRadians(BNXtotal);
  BKpos = calcRadians(BKtotal);
  QNSpos = calcRadians(QNStotal);
  SIpos = calcRadians(SItotal);

}

float calcRadians(float f){
  float percent = (f/Gtotal) * 100;
  float arcDeg = (percent/100) * 360;
  float arcRad = radians(arcDeg);
  return arcRad;
}
