# Arrow test

library(sparklyr)
library(dplyr)
library(microbenchmark)

# start the sparklyr session
master <- "local"
# master <- "spark://master:7077"
# master <- "yarn"
sc <- spark_connect(master = master, config = list("sparklyr.shell.driver-memory" = "6g"))

data <- data.frame(y = runif(10^5, 0, 1))

# Benchmark Data copy_to()
microbenchmark::microbenchmark(
  setup = library(arrow),
  arrow_on = {
    sparklyr_df <<- copy_to(sc, data, overwrite = T)
    count(sparklyr_df) %>% collect()
  },
  arrow_off = {
    if ("arrow" %in% .packages()) detach("package:arrow")
    sparklyr_df <<- copy_to(sc, data, overwrite = T)
    count(sparklyr_df) %>% collect()
  },
  times = 10
) %T>% print() %>% ggplot2::autoplot()

# Benchmark collect()
microbenchmark::microbenchmark(
  setup = library(arrow),
  arrow_on = {
    collect(sparklyr_df)
  },
  arrow_off = {
    if ("arrow" %in% .packages()) detach("package:arrow")
    collect(sparklyr_df)
  },
  times = 10
) %T>% print() %>% ggplot2::autoplot()

# Benchmark data transformation
microbenchmark::microbenchmark(
  setup = library(arrow),
  arrow_on = {
    sample_n(sparklyr_df, 10^4) %>% spark_apply(~ .x / 2) %>% count()
  },
  arrow_off = {
    if ("arrow" %in% .packages()) detach("package:arrow")
    sample_n(sparklyr_df, 10^4) %>% spark_apply(~ .x / 2) %>% count()
  },
  times = 10
) %T>% print() %>% ggplot2::autoplot()

# stop the SparkR session
spark_disconnect(sc)