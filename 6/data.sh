#!/bin/sh
< input.txt \
  sed -E 's/^(...).(...)$/[id|->"\1",to|->"\2"]/g' \
    | tr '\n' ',' \
         | sed -e 's/^/{/' \
               -e 's/,$/}/'
echo
