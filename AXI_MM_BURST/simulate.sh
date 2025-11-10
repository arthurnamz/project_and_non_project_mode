#!/bin/bash
rm -rf *.log *.pb *.jou *.wdb *.str  xsim.dir
xvlog -sv cpu.sv
xvlog cpu_tb.v

xelab cpu_tb -debug all 

xsim cpu_tb -g

