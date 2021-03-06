#Climate Change's Influences: Visualizing Global CO2 and Gross National Income.


This is a [Processing Sketch](http://www.processing.org/) that visualizes data relating to climate change from the [World Bank Data Indicators.](http://data.worldbank.org/indicator) Two visualizations can be toggled using a switch in the upper right corner. Specific data for each country can be viewed by hovering the mouse over each circle. Color scheme was borrowed from Cynthia Brewer's [Color Brewer](http://colorbrewer2.org/) tool. Some code for this sketch was borrowed from a scatterplot graph created by [Christian Marc Schmidt](http://www.openprocessing.org/sketch/51382). 

My intention is for the audience to view a trend that suggests as countries become more affluent their output of CO2 increases. This is important in discussing the problems associated with climate change and potential solutions. For example topics come to mind such as "should developed nations assist developing nations in reducing their CO2 foot print?" and "do developed nations have the sole responsibility to rectify the climate change problem as they are the main culprits of greenhouse gas emissions?"


![country-level-data](https://github.com/clhenrick/data-viz-projects/raw/master/03_scatterplot/scatterplot/images/data-viz-midterm-scatterplot-test8a.png) 

![per-capita-data](https://github.com/clhenrick/data-viz-projects/raw/master/03_scatterplot/scatterplot/images/data-viz-midterm-scatterplot-test8b.png)

##Process:

1. I downloaded data from World Bank Data indicators in the Climate Change category. I noticed problems with the raw data:    
  * Not every country listed has data for the same year.     
  * There are aggregates of countries within the dataset such as "East Asia and the Pacific" or "Sub-Saharan   Africa". While these may be useful, for my data-viz I'm attempting to compare only countries. 
  
2. To sort out countries only from the raw data:
  * Grabbed category data for 2010 as this was the latest year available for the CO2 kt category.     
  * Combined the data into one spread sheet.    
  * Used a `join` in [QGIS](http://qgis.org/en/site/) to a world dataset file so that only matching countries would be imported. I used the 'Country Code' key from the World Bank data and joined it to [Natural Earth](http://www.naturalearthdata.com/)'s ne_10m_admin_0_countries.shp 'Adm0_a3_is' column.     
  * To only keep matching countries from Natural Earth and the World Bank I filtered out data with NULL values using an SQL `WHERE` clause: 
  
	   * ```SQL
	 SELECT * FROM ne_10m_admin_0_countries WHERE "pop_gni_co2_2010_Country Name"  != 'NULL'  AND  "pop_gni_co2_2010_GNI_2010" !='' AND  	"pop_gni_co2_2010_CO2_2010" != '' AND  "pop_gni_co2_2010_POP_2010" != ''	  ``` 

3. I noticed that some countries lacked data for 2010. To fix this I manually added data from the next available previous year to try to fill in the gaps (probably not the most statistically sound method). These problem countries are listed below. A couple countries such as Myanmar and North Korea did not have any data from the World Bank so were excluded from the viz. 
  * Countries shown that had no data for 2010. Their values were replaced with data from next available previous year. The countries and year of data is listed below: 
  
	* Argentina GNI (country & per capita) 2006 
	* Greenland GNI (country & per capita) 2009 
	* Libya GNI 2009
	* Sudan and South Sudan: I split Sudan's CO2 evenly as South Sudan has no data in this category (probably due to it being a relatively new country)
	* Djibouti GNI (country & per capita) 2005
	* Somalia / Somaliland GNI (both) 1990
	* Iran (both GNI) 2009 

4. The data for GNI and CO2 was then mapped to x and y axises respectively using Processing's map() method. A natural logarithm was applied to these two datasets. When graphed, this suggests a linear relationship between growth in GNI and CO2. However, this distorts the fact that some countries with a high level of GNI may not have a high output of CO2. 

5. In future iterations the following features would be added:
   * Animate the circles when switching visualizations.
   * Add an ability to turn on/off the logarithm.
   * Highlight all circles by region when hovering over a region in the legend.
   * Improve the typography.
   * Add a label for the toggle switch.
   * Show a projection of the trend into the future.
   * Toggle a view to display the data on a world map.