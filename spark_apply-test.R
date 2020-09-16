library(dplyr, warn.conflicts = FALSE)
library(sparklyr)

# start the sparklyr session
master <- "local"
# master <- "spark://master:7077"
# master <- "yarn"
sc <- spark_connect(master, spark_home = Sys.getenv("SPARK_HOME"),
                    method = c("shell"), app_name = "sparklyr")

sdf_len(sc, length = 5, repartition = 1) %>%
  spark_apply(function(e) I(e))

# stop the SparkR session
spark_disconnect(sc)