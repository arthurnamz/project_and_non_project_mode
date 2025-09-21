#!/bin/bash

# Simulation script for the complete top-level dot product system
# Compiles and simulates the integrated system

echo "=== Compiling Top-Level Dot Product System ==="

# Compile all modules
iverilog -o top_system_sim \
    top_level_system.v \
    input_memory_wrapper.v \
    output_memory_wrapper.v \
    mem_controller.v \
    mem_reader.v \
    dotProduct.v \
    mem_writer.v \
    mem1.v \
    mem2.v \
    mem3.v \
    top_level_system_tb.v

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful!"
    echo ""
    echo "=== Running Simulation ==="
    vvp top_system_sim
    echo ""
    echo "=== Simulation Complete ==="
else
    echo "✗ Compilation failed!"
    exit 1
fi

# Clean up
echo "Cleaning up simulation files..."
rm -f top_system_sim
echo "Done."
