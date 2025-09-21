# Output Memory Wrapper Testbench Documentation

## 🧪 **Testbench Overview**

This document describes the comprehensive testbench for the `output_memory_wrapper` module, which tests both write and read operations of the output memory wrapper system that stores dot product results.

## **Testbench Structure**

### **Module Under Test**
```verilog
output_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter ADDR_WIDTH = 4,
    parameter MEM_SIZE = 64,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH)
)(
    // Write interface
    input dot_product_result, result_valid, processing_done,
    // Read interface
    input read_en, read_addr, output result_out,
    // Status
    output writer_busy, writer_done
);
```

### **Testbench Components**
- **Clock Generation**: 4ns period (250MHz)
- **Test Data Management**: Various result values and patterns
- **Task-Based Testing**: Modular test functions
- **Comprehensive Verification**: Write and read operation testing

## **Test Cases**

### **Test Case 1: Basic Write and Read Operations**
- **Purpose**: Verify basic functionality
- **Test Data**: Single result value (42)
- **Operations**:
  1. Write a dot product result
  2. Wait for writer to complete
  3. Read the result back
  4. Verify output matches input (with truncation)
- **Expected Result**: Result should be correctly stored and retrieved

### **Test Case 2: Multiple Results**
- **Purpose**: Test multiple result storage
- **Test Data**: Results [10, 15, 20]
- **Operations**:
  1. Write multiple results sequentially
  2. Read each result back
  3. Verify all results are correctly stored
- **Expected Result**: All results should be stored at different addresses

### **Test Case 3: Edge Cases**
- **Purpose**: Test edge case values
- **Test Data**: 
  - Zero result (0)
  - Maximum 8-bit result (255)
- **Operations**:
  1. Write edge case values
  2. Read and verify results
- **Expected Result**: Edge cases should be handled correctly

### **Test Case 4: Truncation Test**
- **Purpose**: Test truncation of wide results
- **Test Data**:
  - Wide result (1024) - should truncate to 0
  - Wide result (300) - should truncate to 44
- **Operations**:
  1. Write wide results (wider than 8 bits)
  2. Read and verify truncation
- **Expected Result**: Wide results should be truncated to 8 bits

### **Test Case 5: Write Operations Only**
- **Purpose**: Test write functionality independently
- **Test Data**: Results [100, 200]
- **Operations**:
  1. Write results without reading
  2. Monitor writer status signals
- **Expected Result**: Write operations should complete successfully

### **Test Case 6: Read Operations Only**
- **Purpose**: Test read functionality independently
- **Operations**:
  1. Read from various addresses
  2. Display read results
- **Expected Result**: Read operations should work correctly

## **Test Tasks**

### **1. `test_basic_write_read` Task**
```verilog
task test_basic_write_read;
    begin
        // Write a result
        dot_product_result = 18'd42;
        result_valid = 1'b1;
        // ... wait for completion
        // Read the result
        read_en = 1'b1;
        read_addr = 0;
        // ... verify result
    end
endtask
```
- **Purpose**: Test basic write-then-read sequence
- **Operations**: Single result write and read verification

### **2. `test_multiple_results` Task**
```verilog
task test_multiple_results;
    begin
        for (i = 0; i < 3; i = i + 1) begin
            // Write multiple results
            dot_product_result = 18'd10 + i * 5;
            // ... write sequence
        end
        // Read all results
        for (i = 0; i < 3; i = i + 1) begin
            // ... read sequence
        end
    end
endtask
```
- **Purpose**: Test multiple result storage and retrieval
- **Operations**: Sequential writes and reads with verification

### **3. `test_edge_cases` Task**
- **Purpose**: Test edge case values
- **Operations**:
  - Zero result testing
  - Maximum 8-bit value testing
  - Verification of edge case handling

### **4. `test_truncation` Task**
- **Purpose**: Test truncation of wide results
- **Operations**:
  - Write results wider than 8 bits
  - Verify proper truncation to 8 bits
  - Test truncation behavior

### **5. `test_write_operations` Task**
- **Purpose**: Test write operations independently
- **Operations**:
  - Write multiple results
  - Monitor writer status signals
  - Verify write completion

### **6. `test_read_operations` Task**
- **Purpose**: Test read operations independently
- **Operations**:
  - Read from various addresses
  - Display read results
  - Verify read functionality

## **Signal Monitoring**

### **Write Interface Signals**
- `dot_product_result`: Result value to be stored
- `result_valid`: Valid signal for result
- `processing_done`: Processing completion signal

### **Read Interface Signals**
- `read_en`: Read enable signal
- `read_addr`: Read address
- `result_out`: Data output from mem3

### **Status Signals**
- `writer_busy`: Writer busy indicator
- `writer_done`: Writer completion signal

### **Monitor Statement**
```verilog
$monitor($time,
  " rst_n=%b dot_product_result=%0d result_valid=%b processing_done=%b writer_busy=%b writer_done=%b read_en=%b read_addr=%0d result_out=%0d",
  rst_n, dot_product_result, result_valid, processing_done, writer_busy, writer_done, read_en, read_addr, result_out);
```

## **Expected Test Results**

### **Successful Test Output**
```
=== Test Case 1: Basic Write and Read ===
Testing basic write and read operations...
  Writer is busy, processing result...
  Writer completed, result stored.
  ✓ Basic write/read PASSED: Expected 42, Got 42

=== Test Case 2: Multiple Results ===
Testing multiple results...
  Result 0 written: 10
  Result 1 written: 15
  Result 2 written: 20
  ✓ Result 0 PASSED: Expected 10, Got 10
  ✓ Result 1 PASSED: Expected 15, Got 15
  ✓ Result 2 PASSED: Expected 20, Got 20

=== Test Case 3: Edge Cases ===
Testing edge cases...
  ✓ Zero result PASSED: Got 0
  ✓ Max 8-bit result PASSED: Got 255

=== Test Case 4: Truncation Test ===
Testing truncation of wide results...
  ✓ Truncation PASSED: Wide result 1024 truncated to 0
  ✓ Truncation PASSED: Wide result 300 truncated to 44
```

### **Test Completion**
```
==========================================
All output memory wrapper tests completed!
==========================================
```

## **Key Features**

### **✅ Comprehensive Coverage**
- Tests all major functionality
- Covers edge cases and truncation
- Verifies signal behavior

### **✅ Truncation Testing**
- Tests wide result truncation
- Verifies 18-bit to 8-bit conversion
- Ensures proper bit handling

### **✅ Status Signal Verification**
- Monitors writer busy/done signals
- Verifies proper handshaking
- Tests signal timing

### **✅ Edge Case Handling**
- Zero value testing
- Maximum value testing
- Boundary condition verification

## **Simulation Script**

### **Compilation Command**
```bash
iverilog -o output_wrapper_sim \
    output_memory_wrapper.v \
    mem_writer.v \
    mem3.v \
    output_memory_wrapper_tb.v
```

### **Simulation Command**
```bash
vvp output_wrapper_sim
```

### **Automated Script**
```bash
./simulate_output_wrapper.sh
```

## **Testing Strategy**

### **1. Functional Testing**
- **Write Operations**: Test result storage functionality
- **Read Operations**: Test result retrieval functionality
- **Integration**: Test write-then-read sequences

### **2. Truncation Testing**
- **Wide Results**: Test results wider than 8 bits
- **Bit Handling**: Verify proper truncation
- **Data Integrity**: Ensure no data corruption

### **3. Edge Case Testing**
- **Zero Values**: Test with zero results
- **Maximum Values**: Test with 0xFF values
- **Boundary Conditions**: Test boundary cases

### **4. Signal Verification**
- **Control Signals**: Verify proper control signal behavior
- **Status Signals**: Verify status signal timing
- **Handshaking**: Verify proper handshaking protocols

## **Truncation Behavior**

### **Result Width Handling**
- **Input**: 18-bit dot product results
- **Storage**: 8-bit values in mem3
- **Truncation**: Lower 8 bits are stored

### **Examples**
- `1024 (0x400)` → `0 (0x00)`
- `300 (0x12C)` → `44 (0x2C)`
- `255 (0xFF)` → `255 (0xFF)`
- `42 (0x2A)` → `42 (0x2A)`

## **Usage**

### **Running the Testbench**
```bash
# Navigate to dotProduct directory
cd dotProduct

# Make script executable
chmod +x simulate_output_wrapper.sh

# Run simulation
./simulate_output_wrapper.sh
```

### **Expected Runtime**
- **Compilation**: ~1-2 seconds
- **Simulation**: ~5-10 seconds
- **Total**: ~10-15 seconds

## **Troubleshooting**

### **Common Issues**
1. **Compilation Errors**: Check file paths and dependencies
2. **Simulation Errors**: Check signal connections
3. **Test Failures**: Review expected vs actual data

### **Debug Tips**
1. **Monitor Signals**: Use the monitor statement output
2. **Check Timing**: Verify clock and reset signals
3. **Verify Truncation**: Check truncation behavior
4. **Status Signals**: Monitor writer busy/done signals

## **Integration Notes**

### **With Dot Product System**
- Receives results from dot product module
- Stores results for later retrieval
- Handles result width conversion

### **With Memory System**
- Uses mem3 for result storage
- Provides read access to stored results
- Manages memory addressing

## **Conclusion**

The output memory wrapper testbench provides comprehensive testing of the output memory wrapper module, ensuring:

- ✅ **Correct Functionality**: Write and read operations work as expected
- ✅ **Truncation Handling**: Wide results are properly truncated
- ✅ **Edge Case Handling**: Zero and maximum values are handled correctly
- ✅ **Signal Integrity**: All control and status signals behave properly
- ✅ **Integration**: Write-then-read sequences work correctly

This testbench is essential for verifying the output memory wrapper functionality before integration into the larger dot product system.
