#!/usr/bin/env python

import ruamel.yaml
import sys
import argparse
parser = argparse.ArgumentParser()

#-db DATABSE -u USERNAME -p PASSWORD -size 20
parser.add_argument("-f", "--values-file", help="Values filename")
parser.add_argument("-c", "--chart-file", help="Chart yaml filename")

args = parser.parse_args()

ryaml = ruamel.yaml.YAML()
with open(args.values_file, "r") as stream:
    try:
        code = ryaml.load(stream)
        ryaml.dump(code, sys.stdout)
    except yaml.YAMLError as exc:
        print(exc)

#with open(args.file, "r") as stream:
#  while True:  
#    line = stream.readline()
#    if not line:
#      break
#    if line.find("@") != -1:
#      print(line.strip())
