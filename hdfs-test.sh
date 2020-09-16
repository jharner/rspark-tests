#!/bin/bash

cd ~/rspark-tests

# make a directory and copy a file from the local filesystem to hdfs
hdfs dfs -mkdir temp
hdfs dfs -ls
hdfs dfs -copyFromLocal cdat.csv temp/
hdfs dfs -ls temp/
hdfs dfs -du

# remove the file and directory from hdfs
hdfs dfs -rm -f temp/cdat.csv
hdfs dfs -rmdir temp