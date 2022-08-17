#!/bin/bash

file_info=$1
bash_script=$2

params=$(awk 'NR=='${SLURM_ARRAY_TASK_ID}'' $file_info)

instruction="$bash_script $params"
echo "$instruction"

$bash_script "$params"