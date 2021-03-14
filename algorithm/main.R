#!/usr/bin/env Rscript
#source("script.R", chdir=TRUE)

# ----Import packages----
library("rjson")
library("reticulate")

# --------xxxx--------

# ----I/O filepath definitions----

input_folder <- "../input_mount" #Part of template. DO NOT EDIT.
output_folder <- "../output_mount" #Part of template. DO NOT EDIT.
param_filepath <- paste0(input_folder, "/parameter.json") #Part of template. DO NOT EDIT.

expression_filepath <- paste0(input_folder, "/expression.csv")
# all files written into the output folder will be available on the Studio interface
# as input for downstream components in a workflow

output_filepath <- paste0(output_folder, "/output.csv")
# -------xxxx-------

# --------Function definitions----------

function_name <- function(df, param1, param2) {

}

# -------Read input--------

df <- read.csv(expression_filepath, stringsAsFactors = F, check.names = F)

# check if row identifiers are provided in a row.names column
# if not, the first column is used as the row identifier
if ("row.names" %in% names(df)) {
  rownames(df) <- df$row.names
  df <- subset(df, select = -c(row.names))
}

# --------xxxx--------

# -----Parse user parameters----
param <- fromJSON(file = param_filepath)

for (key in param$parameter) {
  if (key$name == 'param1') {
    param1 <- key$value
  } else if (key$name == 'param2') {
    param2 <- as.numeric(key$value)
  }
}

# --------xxxx---------

# ------Add algorithm---------
# Add all computation logic here

output_df <- function_name(df, param1, param2)
# -------xxxx--------

# --------Add visualisations---------

viz <- import("viz.studio_viz")
viz$save_table(output_df, "Table Name")

# ----------xxxx-----------
