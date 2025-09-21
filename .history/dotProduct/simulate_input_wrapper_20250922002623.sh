#!/bin/bash

# Simulation script for the input memory wrapper testbench
# Compiles and simulates the input memory wrapper with its dependencies

echo "=== Compiling Input Memory Wrapper Testbench ==="

# Compile all required modules
iverilog -o input_wrapper_sim \
    input_memory_wrapper.v \
    mem_reader.v \
    mem1.v \
    mem2.v \
    input_memory_wrapper_tb.v

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful!"
    echo ""
    echo "=== Running Input Memory Wrapper Simulation ==="
    vvp input_wrapper_sim
    echo ""
    echo "=== Simulation Complete ==="
else
    echo "✗ Compilation failed!"
    exit 1
fi

# Clean up
echo "Cleaning up simulation files..."
rm -f input_wrapper_sim
echo "Done."
