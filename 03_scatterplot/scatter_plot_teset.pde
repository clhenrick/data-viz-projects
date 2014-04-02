// Parsons data viz midterm scatterplot 
// chris henrick, spring 2014
// Code used in this sketch has been reused and altered from:
// http://www.openprocessing.org/sketch/51382

// instead of loading multiple files, combine datasets to one file?
String file1 = "co2-kt-by-country_2010.csv";
String file2 = "GNI_per-country_2012.csv";
String file3 = "pop_total_2012.csv";
String[] files = {file1, file2, file3};

String[] rawData1;
String[] rawData2;
String[] rawData3;
//String[][] allRawData = {rawData1, rawData2, rawData3};
//String[] allRawData = new String[3];

// two-dimensional array to store all data
String[][] processedData = new String[5][252];

int leftMargin = 50;
int rightMargin = 50;
int topMargin = 100;
int bottomMargin = 100;

int minRadius = 10;
int maxRadius = 100;

void setup(){
  size(1000, 600);
  rawData1 = loadStrings(file1);
  rawData2 = loadStrings(file2);
  rawData3 = loadStrings(file3);  
  //printArray(rawData1);  
  parseData();
 
}

void draw(){
  background(255);
  
}

void keyPressed(){
  println("key pressed");
  
}

void parseData(){
  // steps: 
  // 1. find common countries in all 3 datasets
  // 2. only use data from these countries to map to viz
  // 3. use each data set for one of three values
  
  // questions:
  // how to create an array with an unknown length? or just set to 252?
  
  String[] countries = new String[252];
  
  processedData[0][0] = "name";
  processedData[1][0] = "code";
  processedData[2][0] = "co2";
  processedData[3][0] = "gni";
  processedData[4][0] = "pop_total";
  
  
  for (int i = 1; i < processedData.length; i++){
    
    printArray(processedData[i]);
    
      for (int j=1; j<rawData1.length; j++){
        String[] firstRow = split(rawData1[j], ",");
        //printArray(firstRow);
        
        for (int k=1; k<processedData.length; k++){
          //processedData
        }
      }
    
    if (i==0) {
      // do stuff for first dataset
      // find countries without null values
      // check to see if
      
      // map dataset range to scatterplot x domain
    } else if (i==1) {
      // do stuff for second dataset
      // map dataset range to scatterplot y domain
    } else if (i==2) {
      // do stuff for third dataset
      // map dataset range to scatterplot bubble radius
    }
  } // end for i loop
  
} // end parseDat
