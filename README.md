# yelp2geo

Find TERM-related places in CITY and render results as geojson or map.

That is, you can search for places falling in some category ("chinese
takeout") within some city ("Seattle") and render the geocoded location results
in [geojson](http://en.wikipedia.org/wiki/GeoJSON) format or as a map via [geojson.io](http://geojson.io).


## Usage

  yelp2geo [--in CITY] TERM


# Examples

  yelp2geo tacos
  yelp2geo --in Louisville brewpubs
  yelp2geo --in Nashville "chinese takeout"
  yelp2geo --map --in Milwaukee bowling
