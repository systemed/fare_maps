Rail fare maps
==============

A couple of hacked-up scripts to visualise fares from a given station.

## Prerequisites

* Ruby and Python.
* rasem module for Ruby (draws SVGs).
* Get https://github.com/dracos/split-ticket and copy the `split` and `data` directories into this directory.

## Running

Edit `create_output_file_for_station.py` to have your station code instead of CBY. Run it. It'll create a file called `output.json` with all the fares from that station.

Then run any of the .rb scripts to create the relevant maps for that query. They're just examples really - you can parse the fares JSON any which way you choose and draw an SVG from it.