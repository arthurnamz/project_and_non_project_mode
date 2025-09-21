#!/bin/bash

# Simulation script for the output memory wrapper testbench
# Compiles and simulates the output memory wrapper with its dependencies

echo "=== Compiling Output Memory Wrapper Testbench ==="

# Compile all required modules
iverilog -o output_wrapper_sim \
    output_memory_wrapper.v \
    mem_writer.v \
    mem3.v \
    output_memory_wrapper_tb.v

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful!"
    echo ""
    echo "=== Running Output Memory Wrapper Simulation ==="
    vvp output_wrapper_sim
    echo ""
    echo "=== Simulation Complete ==="
else
    echo "✗ Compilation failed!"
    exit 1
fi

# Clean up
echo "Cleaning up simulation files..."
rm -f output_wrapper_sim
echo "Done."
