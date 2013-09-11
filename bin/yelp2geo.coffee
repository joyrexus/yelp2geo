#!/usr/bin/env coffee 
###
Search for places related to TERM in CITY and render geocoded results.

Examples:

  yelp2geo tacos
  yelp2geo --in Louisville brewpubs
  yelp2geo --in Nashville "chinese takeout"
  yelp2geo --map --in Milwaukee bowling

###
{search, map, print} = require '../lib/index'
args = require('optimist')
    .usage('Usage: $0 [--city CITY] TERM')
    .describe('c', 'city to search')
    .alias('c', 'city')
    .alias('c', 'in')
    .describe('m', 'show map of results')
    .alias('m', 'map')

argv = args.argv

if argv.help
  args.showHelp()
  process.exit(0)

term = argv._.join('+')

callback = if argv.map then map else print
search(term, argv.city, callback)
