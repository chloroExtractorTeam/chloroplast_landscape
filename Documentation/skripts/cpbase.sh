#!/bin/bash

curl http://rocaplab.ocean.washington.edu/tools/cpbase_test/run/ | grep href | grep genome | grep td | cut -f3 -d ">" | cut -f1 -d"<"
