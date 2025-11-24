#!/bin/sh
./clean.sh
 TOP_LEVEL=$1

echo "Compiling Verilog files..."
xvlog *.v
if [ $? -ne 0 ]; then
    echo "ERROR: Compilation failed!"
    exit 1
fi

echo "Elaborating design..."
xelab $TOP_LEVEL -debug all -timescale 1ns/1ps
if [ $? -ne 0 ]; then
    echo "ERROR: Elaboration failed!"
    exit 1
fi

echo "Running simulation..."
xsim $TOP_LEVEL -g -protoinst axi_write_burst_fifo.protoinst
