Elevation Profile of the Pacific Crest Trail using D3JS
====================

## Data
[Half-Mile PCT](http://www.pctmap.net/gps/) GPX track points.

## Process
Use PostGIS to compute distance from a point and it's nearest neighbor with an index value of n-1. 

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

Then use [D3JS](d3js.org) to visualize as an area graph.

## Progress
Update with down-sampled data using distance for x value calculated with PostGIS:
![](https://github.com/clhenrick/data-viz-projects/raw/master/04_elevation_profile/images/ca_section_d_profile_using_distance.png)

Original trial with sample data using elevation on y axis and index number for x axis:
![](https://github.com/clhenrick/data-viz-projects/raw/master/04_elevation_profile/images/ca_section_d_profile.png)
