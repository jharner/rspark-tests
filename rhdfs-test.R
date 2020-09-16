options(warn=-1)

Sys.getenv(c("HADOOP_HOME", "HADOOP_CMD"))
setwd("/home/rstudio/rspark-tests")

# load rhdfs library and initialize rhdfs
library(rhdfs)
hdfs.init()

# retrieve rhdfs defaults
hdfs.defaults("conf")

# make a directory and copy a file from the local filesystem to hdfs using rhdfs
hdfs.mkdir("temp")
hdfs.put("cdat.csv", "temp")
hdfs.ls("temp")

# remove the file and directory from hdfs
hdfs.rm("temp/cdat.csv")
hdfs.rm("temp")
