#!/bin/bash

# Bake Environment vars:
/usr/local/bin/var_baker.sh  lamernews/app_config.rb

# Start passenger
cd lamernews && passenger start --port 8080
