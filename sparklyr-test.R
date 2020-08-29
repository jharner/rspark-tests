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
sc <- spark_connect(master = "local")
# sc <- spark_connect(master = "spark://master:7077")

faithful_tbl <- copy_to(sc, faithful, "faithful_sdf", overwrite = TRUE)
src_tbls(sc)

# stop the SparkR session
spark_disconnect(sc)
