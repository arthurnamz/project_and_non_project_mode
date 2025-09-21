#!/bin/bash

# Simulation script for Pipelined Dot Product System
# This script compiles and simulates the dot product modules

echo "=========================================="
echo "Pipelined Dot Product System Simulation"
echo "=========================================="

# Create simulation directory
mkdir -p sim_results

# Compile and simulate dot product module testbench
echo "Compiling dot product module testbench..."
iverilog -o sim_results/dotProduct_sim dotProduct.v dotProduct_tb.v
if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    echo "Running dot product module simulation..."
    vvp sim_results/dotProduct_sim > sim_results/dotProduct_results.txt
    echo "✓ Simulation completed"
    echo "Results saved to sim_results/dotProduct_results.txt"
else
    echo "✗ Compilation failed"
    exit 1
fi

echo ""

# Compile and simulate integrated system testbench
echo "Compiling integrated system testbench..."
iverilog -o sim_results/integrated_sim dotProduct.v mem_controller.v memoryReadController.v memory.v mem1.v mem2.v integrated_dotProduct_tb.v
if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
    echo "Running integrated system simulation..."
    vvp sim_results/integrated_sim > sim_results/integrated_results.txt
    echo "✓ Simulation completed"
    echo "Results saved to sim_results/integrated_results.txt"
else
    echo "✗ Compilation failed"
    exit 1
fi

echo ""
echo "=========================================="
echo "Simulation Summary:"
echo "=========================================="
echo "1. Dot Product Module Test:"
echo "   - Results: sim_results/dotProduct_results.txt"
echo "   - Tests individual dot product computation"
echo ""
echo "2. Integrated System Test:"
echo "   - Results: sim_results/integrated_results.txt"
echo "   - Tests complete memory + dot product system"
echo ""
echo "Check the result files for detailed test outputs."
echo "=========================================="
