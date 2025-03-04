#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <input.bam> <output_file>"
  exit 1
fi

# Get input BAM file and output file path from command line arguments
INPUT_BAM=$1
OUTPUT_FILE=$2

# Check if the input BAM file exists
if [ ! -f "$INPUT_BAM" ]; then
  echo "Error: BAM file $INPUT_BAM not found!"
  exit 1
fi

# Index the BAM file using samtools
#echo "Indexing BAM file..."
#samtools index $INPUT_BAM

# Check if the index was successfully created
#if [ ! -f "${INPUT_BAM}.bai" ]; then
  #echo "Error: Failed to create index for $INPUT_BAM!"
  #exit 1
#fi

# Use samtools idxstats to calculate coverage and redirect the output to the specified file
echo -e "Chromosome Name\tChromosome Length\tNumber of Mapped Reads\tNumber of Unmapped Reads" > $OUTPUT_FILE
echo "Calculating coverage..."
module load samtools
samtools idxstats $INPUT_BAM >> $OUTPUT_FILE

# Check if coverage calculation was successful
if [ $? -eq 0 ]; then
  echo "Coverage calculated successfully. Output written to $OUTPUT_FILE."
else
  echo "Error: Coverage calculation failed!"
  exit 1
fi
