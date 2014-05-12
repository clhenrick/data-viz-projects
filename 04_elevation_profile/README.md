Elevation Profile of the Pacific Crest Trail using D3JS
====================

## Data Source
[Half-Mile PCT](http://www.pctmap.net/gps/) GPX track points.

## Process
1. Use QGIS to down-sample the data by selecting 1/50 of the data points using the query selector.

2. Use PostGIS to compute distance from a point and it's nearest neighbor with an index value of n - 1 with the following query: 

```sql
UPDATE ca_sec_a_track_simp2
SET dist = (SELECT
  ST_Distance(
    ca_sec_a_track_simp2.the_geom::geography,
    t2.the_geom::geography)
  FROM ca_sec_a_track_simp2 t2
  WHERE t2.id <> ca_sec_a_track_simp2.id
  ORDER BY 
   ca_sec_a_track_simp2.the_geom <-> t2.the_geom
  LIMIT 1
)
``` 
3. Then use [D3JS](d3js.org) to visualize as an area graph.

## Progress
**Using down-sampled data of the entire trail and visualizing as a zoomable area graph.** 
**the whole graph:**
![](https://github.com/clhenrick/data-viz-projects/raw/master/04_elevation_profile/images/pct_elev_profile_zoomable.png)

**zoomed in:**
![](https://github.com/clhenrick/data-viz-projects/raw/master/04_elevation_profile/images/pct_elev_profile_zoomable2.png)

**Update no. 2 with down-sampled data using distance for x value calculated with PostGIS:**
![](https://github.com/clhenrick/data-viz-projects/raw/master/04_elevation_profile/images/ca_section_d_profile_using_distance.png)

**Original viz of trial with sample data using elevation on y axis and index number for x axis:**
![](https://github.com/clhenrick/data-viz-projects/raw/master/04_elevation_profile/images/ca_section_d_profile.png)

