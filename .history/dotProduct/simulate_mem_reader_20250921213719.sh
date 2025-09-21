#!/bin/bash

# Simulation script for Modified Memory Reader System
# This script compiles and simulates the memory reader with direct outputs from mem1 and mem2

echo "=========================================="
echo "Modified Memory Reader System Simulation"
echo "=========================================="

# Create simulation directory
mkdir -p sim_results

# Compile and simulate memory reader testbench
echo "Compiling memory reader testbench..."
iverilog -o sim_results/mem_reader_sim mem_reader.v mem_reader_tb.v mem1.v mem2.v
if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    echo "Running memory reader simulation..."
    vvp sim_results/mem_reader_sim > sim_results/mem_reader_results.txt
    echo "✓ Simulation completed"
    echo "Results saved to sim_results/mem_reader_results.txt"
else
    echo "✗ Compilation failed"
    exit 1
fi

echo ""

# Compile and simulate integrated system testbench
echo "Compiling integrated memory reader system testbench..."
iverilog -o sim_results/integrated_mem_reader_sim mem_reader.v mem_controller.v dotProduct.v mem1.v mem2.v integrated_mem_reader_tb.v
if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    echo "Running integrated memory reader system simulation..."
    vvp sim_results/integrated_mem_reader_sim > sim_results/integrated_mem_reader_results.txt
    echo "✓ Simulation completed"
    echo "Results saved to sim_results/integrated_mem_reader_results.txt"
else
    echo "✗ Compilation failed"
    exit 1
fi

echo ""
echo "=========================================="
echo "Simulation Summary:"
echo "=========================================="
echo "1. Memory Reader Test:"
echo "   - Results: sim_results/mem_reader_results.txt"
echo "   - Tests memory reader with direct outputs from mem1 and mem2"
echo ""
echo "2. Integrated Memory Reader System Test:"
echo "   - Results: sim_results/integrated_mem_reader_results.txt"
echo "   - Tests complete memory controller + memory reader + dot product system"
echo ""
echo "Key Features of Modified Memory Reader:"
echo "   - Direct outputs from mem1 and mem2"
echo "   - Simplified interface"
echo "   - Integrated with existing memory controller"
echo "   - Compatible with pipelined dot product module"
echo ""
echo "Check the result files for detailed test outputs."
echo "=========================================="
