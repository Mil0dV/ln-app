#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Please call this script with a file to bake (fill with env vars)'
    exit 1
fi

# Here we grep all env vars from the file given as argument
# for each the next block gets called with the env var as 'var'
grep ENVVAR_ $1 | cut -d'/' -f3 | cut -d':' -f1 | while read var
do
  # Via double substitution the contents of the env var is stored as value
  eval "value=\${$var}" &&
  # finally the correct value gets inserted
  sed -i -e "s/$var/$value/" $1
done
