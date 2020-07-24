#!/usr/bin/env Rscript
source("script.R", chdir=TRUE)

# ----Import packages----
library("rjson")
library("tidyr")

# --------xxxx--------

# ----I/O filepath definitions----
input_folder <- "../input_mount"
param_filepath <- paste0(input_folder, "/parameter.json")
input_filepath <- paste0(input_folder, "/data_file.csv")
metadata_filepath <- paste0(input_folder, "/metadata.csv")

output_folder <- "../output_mount"
output_filepath <- paste0(output_folder, "/output_file1.csv")
# -------xxxx-------

# -------Data import--------
df <- read.csv(input_filepath, stringsAsFactors = F, check.names = F)
if ("row.names" %in% names(df)) {
  rownames(df) <- df$row.names
  df <- subset(df, select = -c(row.names))
} else {
  rownames(df) <- df[,1]
}
metadata_df <- read.csv(metadata_filepath, stringsAsFactors = F, check.names = F)
rownames(metadata_df) <- metadata_df[, 1]
# --------xxxx--------

# -----Parse user parameters----
param <- fromJSON(file = param_filepath)

for (key in param$parameter) {
  if (key$name == 'param1_name') {
    param1 <- key$value
  }
  else if (key$name == 'param2_name') {
    param2 <- key$value
  }
}
# --------xxxx---------

# ------Add algorithm---------
# Add all computation logic here
output_df <- function_name(df, param1, param2)
# -------xxxx--------

# -----Write output file-----
output_df$row.names = rownames(output_df)
write.csv(output_df, output_filepath, row.names=F)
# -------xxxx-------
