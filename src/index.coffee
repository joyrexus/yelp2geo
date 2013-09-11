req = require 'request'
queue = require 'queue-async'
config = require '../config'
open = require 'opener'
yelp = require('yelp').createClient config


coords = (name, address, data) -> 
  loc = data.results[0].geometry.location
  lat = loc.lat
  lon = loc.lng
  feature = 
    type: "Feature"
    properties:
      name: name
      address: address
      lat: "#{lat}"
      lon: "#{lon}"
    geometry:
      type: "Point"
      coordinates: [lon, lat]

find = (name, address, callback, final) -> 
  url = "https://maps.googleapis.com/maps/api/geocode/json?address=\"#{address}\"&sensor=false"
  req url, (err, res, body) -> 
    result = callback name, address, JSON.parse(body)
    final null, result

address = (b) -> b.location.display_address.join(', ')

q = queue()

exports.map = (err, geojson) ->
  try
    url = 'http://geojson.io/#data=data:application/json,' 
    open url + encodeURIComponent(geojson)
  catch e then console.error e

exports.print = (err, geojson) -> console.log geojson

exports.search = (term, city, callback) ->

  render = (err, data) ->
    q.defer(find, b.name, address(b), coords) for b in data.businesses
    q.awaitAll (err, results) -> 
      output = 
        type: "FeatureCollection"
        features: results
      geojson = JSON.stringify(output)
      callback err, geojson

  query = 
    term: term or config.default.term
    location: city or config.default.city

  yelp.search query, render

