{exec} = require 'child_process'

task 'build', 'Build javascript files from source', ->
  report = (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr if stdout or stderr
  exec 'coffee -co lib/ src/', report
