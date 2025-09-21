# Input Memory Wrapper Testbench Documentation

## 🧪 **Testbench Overview**

This document describes the comprehensive testbench for the `input_memory_wrapper` module, which tests both write and read operations of the input memory wrapper system.

## **Testbench Structure**

### **Module Under Test**
```verilog
input_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5
)(
    // Write interface
    input write_en, write_addr, data_a, data_b,
    // Read interface  
    input start_reading,
    output reading_done, mem1_output, mem2_output, data_valid, element_count
);
```

### **Testbench Components**
- **Clock Generation**: 4ns period (250MHz)
- **Test Vector Management**: Organized test data
- **Task-Based Testing**: Modular test functions
- **Comprehensive Verification**: Write and read operation testing

## **Test Cases**

### **Test Case 1: Basic Write and Read Operations**
- **Purpose**: Verify basic functionality
- **Test Data**: 
  - Vector A: [1, 2, 3, 4]
  - Vector B: [5, 6, 7, 8]
- **Operations**:
  1. Write test vectors to memories
  2. Start reading sequence
  3. Verify output matches input
- **Expected Result**: Data written should be correctly read back

### **Test Case 2: Write Operations Only**
- **Purpose**: Test write functionality independently
- **Test Data**:
  - Single writes: A=0xAA, B=0xBB at addr=0
  - Single writes: A=0xCC, B=0xDD at addr=1
  - Overwrite: A=0xEE, B=0xFF at addr=0
- **Operations**:
  1. Write individual data elements
  2. Test overwrite functionality
- **Expected Result**: Data should be correctly stored and overwritten

### **Test Case 3: Read Operations Only**
- **Purpose**: Test read functionality independently
- **Operations**:
  1. Start reading sequence
  2. Monitor data output and control signals
  3. Verify reading completion
- **Expected Result**: Reading sequence should complete successfully

### **Test Case 4: Different Vector Values**
- **Purpose**: Test with different data patterns
- **Test Data**:
  - Vector A: [0x10, 0x20, 0x30, 0x40]
  - Vector B: [0x50, 0x60, 0x70, 0x80]
- **Operations**:
  1. Write new test vectors
  2. Read and verify results
- **Expected Result**: Different data patterns should be handled correctly

### **Test Case 5: Edge Case - All Zeros**
- **Purpose**: Test with zero values
- **Test Data**:
  - Vector A: [0, 0, 0, 0]
  - Vector B: [0, 0, 0, 0]
- **Operations**:
  1. Write zero vectors
  2. Read and verify results
- **Expected Result**: Zero values should be handled correctly

### **Test Case 6: Edge Case - Maximum Values**
- **Purpose**: Test with maximum 8-bit values
- **Test Data**:
  - Vector A: [0xFF, 0xFF, 0xFF, 0xFF]
  - Vector B: [0xFF, 0xFF, 0xFF, 0xFF]
- **Operations**:
  1. Write maximum value vectors
  2. Read and verify results
- **Expected Result**: Maximum values should be handled correctly

## **Test Tasks**

### **1. `write_test_vectors` Task**
```verilog
task write_test_vectors;
    input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
    input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
    integer i;
    begin
        for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
            @(posedge clk);
            write_en = 1'b1;
            write_addr = i[ADDR_WIDTH-1:0];
            data_a = vec_a[i];
            data_b = vec_b[i];
            @(posedge clk);
            write_en = 1'b0;
        end
    end
endtask
```
- **Purpose**: Write complete vectors to memory
- **Parameters**: Two arrays of vector data
- **Operations**: Sequential writes for each vector element

### **2. `start_reading_and_verify` Task**
```verilog
task start_reading_and_verify;
    input [DATA_WIDTH-1:0] expected_vec_a [0:VECTOR_WIDTH-1];
    input [DATA_WIDTH-1:0] expected_vec_b [0:VECTOR_WIDTH-1];
    // ... verification logic
endtask
```
- **Purpose**: Start reading and verify output data
- **Parameters**: Expected vector data for comparison
- **Operations**: 
  1. Start reading sequence
  2. Collect output data
  3. Compare with expected values
  4. Report pass/fail status

### **3. `test_write_operations` Task**
- **Purpose**: Test write operations independently
- **Operations**:
  - Single writes to different addresses
  - Overwrite operations
  - Verification of write functionality

### **4. `test_read_operations` Task**
- **Purpose**: Test read operations independently
- **Operations**:
  - Start reading sequence
  - Monitor output signals
  - Verify completion

## **Signal Monitoring**

### **Write Interface Signals**
- `write_en`: Write enable signal
- `write_addr`: Write address
- `data_a`: Data for mem1
- `data_b`: Data for mem2

### **Read Interface Signals**
- `start_reading`: Start reading sequence
- `reading_done`: Reading completion signal
- `mem1_output`: Data output from mem1
- `mem2_output`: Data output from mem2
- `data_valid`: Data valid signal
- `element_count`: Current element counter

### **Monitor Statement**
```verilog
$monitor($time,
  " rst_n=%b write_en=%b write_addr=%0d data_a=0x%h data_b=0x%h start_reading=%b reading_done=%b mem1_output=0x%h mem2_output=0x%h data_valid=%b element_count=%0d",
  rst_n, write_en, write_addr, data_a, data_b, start_reading, reading_done, mem1_output, mem2_output, data_valid, element_count);
```

## **Expected Test Results**

### **Successful Test Output**
```
=== Test Case 1: Basic Write and Read ===
Writing test vectors to input memory wrapper...
  Element 0: A=1, B=5 at addr=0
  Element 1: A=2, B=6 at addr=1
  Element 2: A=3, B=7 at addr=2
  Element 3: A=4, B=8 at addr=3
Vector writing complete.
Starting reading sequence...
  Read element 0: A=1, B=5 (element_count=0)
  Read element 1: A=2, B=6 (element_count=1)
  Read element 2: A=3, B=7 (element_count=2)
  Read element 3: A=4, B=8 (element_count=3)
Reading sequence complete.
Verifying results...
  ✓ Element 0 PASSED: A=1, B=5
  ✓ Element 1 PASSED: A=2, B=6
  ✓ Element 2 PASSED: A=3, B=7
  ✓ Element 3 PASSED: A=4, B=8
```

### **Test Completion**
```
==========================================
All input memory wrapper tests completed!
==========================================
```

## **Simulation Script**

### **Compilation Command**
```bash
iverilog -o input_wrapper_sim \
    input_memory_wrapper.v \
    mem_reader.v \
    mem1.v \
    mem2.v \
    input_memory_wrapper_tb.v
```

### **Simulation Command**
```bash
vvp input_wrapper_sim
```

### **Automated Script**
```bash
./simulate_input_wrapper.sh
```

## **Testing Strategy**

### **1. Functional Testing**
- **Write Operations**: Test data storage functionality
- **Read Operations**: Test data retrieval functionality
- **Integration**: Test write-then-read sequences

### **2. Edge Case Testing**
- **Zero Values**: Test with all-zero data
- **Maximum Values**: Test with 0xFF values
- **Overwrite**: Test overwriting existing data

### **3. Signal Verification**
- **Control Signals**: Verify proper control signal behavior
- **Data Signals**: Verify correct data flow
- **Timing**: Verify proper timing relationships

### **4. Error Detection**
- **Data Mismatch**: Detect incorrect data output
- **Signal Issues**: Detect control signal problems
- **Timing Issues**: Detect timing-related problems

## **Key Features**

### **✅ Comprehensive Coverage**
- Tests all major functionality
- Covers edge cases
- Verifies signal behavior

### **✅ Modular Design**
- Task-based testing approach
- Reusable test functions
- Clear test organization

### **✅ Detailed Verification**
- Step-by-step verification
- Clear pass/fail reporting
- Detailed logging

### **✅ Easy to Run**
- Automated simulation script
- Clear output format
- Easy to interpret results

## **Usage**

### **Running the Testbench**
```bash
# Navigate to dotProduct directory
cd dotProduct

# Make script executable
chmod +x simulate_input_wrapper.sh

# Run simulation
./simulate_input_wrapper.sh
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
3. **Verify Data**: Check data flow through the system

## **Conclusion**

The input memory wrapper testbench provides comprehensive testing of the input memory wrapper module, ensuring:

- ✅ **Correct Functionality**: Write and read operations work as expected
- ✅ **Edge Case Handling**: Zero and maximum values are handled correctly
- ✅ **Signal Integrity**: All control and data signals behave properly
- ✅ **Integration**: Write-then-read sequences work correctly

This testbench is essential for verifying the input memory wrapper functionality before integration into the larger dot product system.
