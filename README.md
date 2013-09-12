# yelp2geo

Find TERM-related places in CITY and render results as geojson or map.

![conversion process](images/convert.png)

That is, you can search for places falling in some category ("chinese
takeout") within some city ("Seattle") and render the geocoded location results
in [geojson](http://en.wikipedia.org/wiki/GeoJSON) format or as a map via [geojson.io](http://geojson.io).


## Usage

### CLI

    yelp2geo [--in CITY] [--map] TERM

For example ...

    yelp2geo tacos
    yelp2geo --in Louisville brewpubs
    yelp2geo --in Nashville "chinese takeout"
    yelp2geo --in Milwaukee --map "bowling alleys"

### API

```coffeescript
{search, print, map} = require 'yelp2geo'

callback = (err, geojson) -> console.log geojson

search('coffee', 'Seattle', callback)
search('denim', 'Nashville', print)
search('bourbon', 'Louisville', map)
```

## Config

You need to add your [Yelp API](http://www.yelp.com/developers/getting_started/api_overview) key and whatnot in `config.json`.

Request API access [here](http://www.yelp.com/developers/getting_started/api_access).

You can also specify your default city and search term of interest:

    {
      "consumer_key": "YOUR_YELP_CONSUMER_KEY",
      "consumer_secret": "YOUR_YELP_CONSUMER_SECRET",
      "token": "YOUR_YELP_TOKEN",
      "token_secret": "YOUR_YELP_TOKEN_SECRET",
      "default": {
        "city": "Nashville",
        "term": "tacos"
      }
    }


## Install

1. Download or clone repo.

2. Add your [Yelp API](http://www.yelp.com/developers/getting_started/api_overview) key and default prefs in `config.json`.

3. `npm -g install`

... OR ...

    npm install yelp2geo


## Limitations

`yelp2geo` utilizes two API services: Yelp's Search API and Google's Geocoding API.  Both services limit the number and frequency of requests you can make.  The geocoding service is [particularly restrictive](https://developers.google.com/maps/documentation/geocoding/index#Limits), so we've limited the number of search results returned from Yelp that actually get geocoded.  That is, you'll only get the top 10 results for "tacos" in "Los Angeles" instead of the full list.
