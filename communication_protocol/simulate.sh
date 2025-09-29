#!/bin/bash
./clean.sh
xvlog cpu.v
xvlog top.v
xvlog top_tb.v

xelab top_tb -debug all 

xsim top_tb -R
