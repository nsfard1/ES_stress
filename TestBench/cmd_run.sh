#!/bin/bash
for i in `seq $1 $2`;
do
   ssh 127x${i}.csc.calpoly.edu "$3"
done