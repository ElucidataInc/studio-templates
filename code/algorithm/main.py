# -------Import packages-------
import pandas as pd
import numpy as np
import os.path
import json
import sys
# ------xxxx-------

# --------Input-output filepaths--------
input_folder = "../input_mount"
input_filepath = input_folder + "/expression.csv"
metadata_filepath = input_folder + "/metadata.csv"
param_filepath = input_folder + "/parameter.json"
output_folder = "../output_mount"
output_filepath = output_folder + "/output.csv"
# ----------xxxx---------

# --------Function definitions----------
def function1(df, arg1, arg2):
    print(df)
    return df
# --------xxxx---------

# -------Read input----------
if os.path.exists(met_csv):
    df = pd.read_csv(met_csv, index_col = False)
else:
    sys.exit("Data file not found")

if 'row.names' in list(df.columns.values):
    df = df.set_index('row.names')
else:
    df = df.set_index(list(df.columns.values)[0])

if os.path.exists(metadata_filepath):
    met_df = pd.read_csv(metadata_filepath, index_col = 0)
else:
    sys.exit("Cohort file not found")
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
output_df = function1(df, param1, param2)
# -------xxxx-------

# -------Save output files-------
output_df.to_csv(output_filepath, index = False)
# -----xxxx--------