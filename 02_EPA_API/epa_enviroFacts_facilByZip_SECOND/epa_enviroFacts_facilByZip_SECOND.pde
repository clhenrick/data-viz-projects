import com.temboo.core.*;
import com.temboo.Library.EnviroFacts.Toxins.*;

// Create a session using your Temboo account application details
TembooSession session = new TembooSession("boris", "myFirstApp", "79ee5cc3326f4627895efcf270f2543e");

String zipcode = "11222";
String[] allFacilityNames = new String[17];
String[] allFacilityIDs = new String[17];
int[] triChemID;

PFont fontFacilityName;
PFont copy;
PFont title;
PFont subTitle;
PFont footer;
PFont footerBold;

XML facilityResults;

ArrayList<Facility> allFacilities = new ArrayList<Facility>();

// copy
String titleText = "Toxics Release Invetory Facilities";
String copyText = "The following facilities are monitored by the EPA for using and releasing toxic chemicals that pose a threat to human health and the environment.";
String subTitleText = "For the zipcode tabulation area: " + zipcode;
String footerTextBold = "data source: ";
String footerText = "EPA Envirofacts";
String urlText = "http://www.epa.gov/enviro/facts/services.html";

void setup() {
  size(500, 500);
  //theseIDs = new String[16];
  smooth();
  
  titleText = titleText.toUpperCase();
  
  //fonts
  fontFacilityName = loadFont("SansSerif-12.vlw");
  copy = createFont("GillSans-Light", 9);
  title = createFont("GillSans-Bold", 14);
  subTitle = createFont("GillSans", 13);
  footer = createFont("GillSans-Light", 11);
  footerBold = createFont("GillSans-Bold", 11);
  
  fill(0);
  
  // Run the FacilitiesSearchByZip Choreo function
  runFacilitiesSearchByZipChoreo();
  parseXML();
}

void draw(){
  background(255);
  renderText();
}

void renderText(){
  // make text for each value being rendered
  
  int marginTop = 100;
  int marginLeft = 50;
  
  textFont(title);
  text(titleText, marginLeft, 50);
  
  textFont(subTitle);
  text(subTitleText, marginLeft, 65);
  
  stroke(100);
  line(50, 75, 300, 75);
  
   
  println("allFacilities.length: " + allFacilityNames.length);
  
  for (int i = 0; i < allFacilityNames.length; i++){
    textFont(fontFacilityName);
    String name = allFacilityNames[i];
    text("*" + name, marginLeft, marginTop + (i * 20));
  }
  
  textFont(footerBold);
  text(footerTextBold, marginLeft, marginTop + (allFacilityNames.length * 21));
  textFont(footer);
  text(footerText, marginLeft + 70, marginTop + (allFacilityNames.length * 21));
  text(urlText, marginLeft, marginTop + (allFacilityNames.length * 21) + 12);
  
}

void parseXML() {
  println("getFacilityNameFromXML called"); 
  
  XML[] facilities = facilityResults.getChildren("tri_facility");
  printArray("facilities: " + facilities);  
  

  // SECOND TRY!!!
  for (int i=0; i<facilities.length; i++){
    //prints datatype: Lprocessing.data.XML;@...
    //println("facilites[i]: " + facilities);
    
    XML facility = facilities[i];
    // prints the XML data for each facility
    //println("facility: " + facility);
    
    XML[] facilityProperties = facility.getChildren();
    // prints processing data type
    //println("facility children: " + facilityProperties);
    
    XML[] facilityName = facility.getChildren("FACILITY_NAME");
    // prints processing data type
    //println("facilityName: " + facilityName);
    
    for (int j=0; j<facilityName.length; j++){
      String thisFacilityName = facilityName[j].getContent();
      // prints each name as a string
      //println("thisFacilityName: " + thisFacilityName);
      
      // add each name to the global array allFacilityNames
      // works! (i think?)
      allFacilityNames[i] = thisFacilityName;
    }
  }
}

void runFacilitiesSearchByZipChoreo() {
  // Create the Choreo object using your Temboo session
  FacilitiesSearchByZip facilitiesSearchByZipChoreo = new FacilitiesSearchByZip(session);

  // Set inputs
  facilitiesSearchByZipChoreo.setZip(zipcode);

  // Run the Choreo and store the results
  FacilitiesSearchByZipResultSet facilitiesSearchByZipResults = facilitiesSearchByZipChoreo.run();
  
  // Print results
  //println(facilitiesSearchByZipResults.getResponse());
  
  //**store results in xml object
  facilityResults = parseXML(facilitiesSearchByZipResults.getResponse());
  //println(facilityResults);
  
  //parseXML();

}

