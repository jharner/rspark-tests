#!/bin/bash

# retrieve rhdfs defaults
hdfs.defaults()

# make a directory and copy a file from the local filesystem to hdfs using rhdfs
library(rhdfs)
hdfs.mkdir("temp")
hdfs.put("cdat.csv", "/temp")
hdfs.ls("temp", recurse = TRUE)

# remove the file and directory from hdfs
hdfs.rm("temp/cdat.csv")
hdfs.rm("temp")