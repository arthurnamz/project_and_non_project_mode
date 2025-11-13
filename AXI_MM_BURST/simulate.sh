#!/bin/bash
if [ -f clean.sh ]; then
    ./clean.sh
else
    echo "clean.sh not found, using default cleanup"
    rm -rf *.log *.pb *.jou *.wdb *.str  xsim.dir
fi

echo "Compiling design..."
xvlog memory.v
xvlog alu.v
xvlog -sv cpu.sv
xvlog cpu_tb.v

echo "Elaborating design..."
xelab cpu_tb -debug all

echo "Running simulation..."
xsim cpu_tb -R

