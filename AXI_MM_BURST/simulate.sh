#!/bin/bash
rm -rf *.log *.pb *.jou *.wdb *.str  xsim.dir

echo "Compiling design..."
xvlog memory.v
xvlog -sv cpu.sv
xvlog cpu_tb.v

echo "Elaborating design..."
xelab cpu_tb -debug all

echo "Running simulation..."
xsim cpu_tb -R

