#!/usr/bin/env python

import argparse
import itertools
import re
import urllib
import os, json

import codecs
import sys
sys.stdout = codecs.getwriter('utf8')(sys.stdout)

from split import fares, prompt, utils, times

data_files = [ 'restrictions', 'stations', 'routes', 'clusters' ]
data = {}
for d in data_files:
    with open(os.path.join(os.path.dirname(__file__), 'data', d + '.json')) as fp:
        data[d] = json.load(fp)

Fares = fares.Fares({}, {}, {})

fare_list = {}
for sta in data['stations']:
	print(sta)
	fare_list[sta] = Fares.get_fares('CBY',sta)

f = open('output.json','w')
f.write(json.dumps(fare_list))
f.close()
