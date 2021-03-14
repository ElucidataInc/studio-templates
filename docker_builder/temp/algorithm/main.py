# -------Import packages-------
import pandas as pd
import numpy as np
import os.path
import json
import sys
# ------xxxx-------

# --------Input-output filepaths--------
input_folder = "../input_mount" #Part of template. DO NOT EDIT
param_filepath = input_folder + "/parameter.json" #Part of template. DO NOT EDIT
output_folder = "../output_mount" #Part of template. DO NOT EDIT

expression_filepath = input_folder + "/expression.csv"

# all files written into the output folder will be available on the Studio interface
# as input for downstream components in a workflow
output_filepath = output_folder + "/output.csv"
# ----------xxxx---------

# --------Function definitions----------
def function_name(df, param1, param2):
    return df
# --------xxxx---------

# -------Read input----------
if os.path.exists(expression_filepath):
    df = pd.read_csv(expression_filepath, index_col = False)
else:
    sys.exit("Expression file not found")

# check if row identifiers are provided in a row.names column
# if not, the first column is used as the row identifier
if 'row.names' in list(df.columns.values):
    df = df.set_index('row.names')
else:
    df = df.set_index(list(df.columns.values)[0])

# -------xxxx---------

# ---------Read user-selected parameters--------
with open(param_filepath) as f:
  param = json.load(f)

for key in param['parameter']:
    name = key['name']
    value = key['value']
    if name == 'param1':
        param1 = value
    elif name == 'param2':
        param2 = int(value)

# --------xxxx--------

# ------Add algorithm--------

output_df = function_name(df, param1, param2)

# -------xxxx-------

# -------Write output files-------
output_df.to_csv(output_filepath, index = False)
# -------xxxx--------

# ---------Add visualisations---------

# Source visualisation library
from viz import studio_viz

# Create a table with the given title on Polly Data Studio
studio_viz.save_table(output_df, "Table Title")
# ------------xxxx------------