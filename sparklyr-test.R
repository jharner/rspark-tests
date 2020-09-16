# load sparklyr
if (nchar(Sys.getenv("HADOOP_HOME")) < 1) {
  Sys.setenv(HADOOP_HOME = "/opt/hadoop")
}
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/opt/spark")
}
library(sparklyr)
library(dplyr)

# start the sparklyr session
master <- "local"
# master <- "spark://master:7077"
# master <- "yarn"
sc <- spark_connect(master = master)

faithful_tbl <- copy_to(sc, faithful, "faithful_sdf", overwrite = TRUE)
src_tbls(sc)

# stop the SparkR session
spark_disconnect(sc)
