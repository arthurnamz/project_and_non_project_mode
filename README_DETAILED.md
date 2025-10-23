# Detailed CPU System Operation Guide

## Table of Contents
1. [System Overview](#system-overview)
2. [Memory Architecture](#memory-architecture)
3. [How Instruction Memory Works](#how-instruction-memory-works)
4. [How Data Memory Works](#how-data-memory-works)
5. [CPU Execution Flow](#cpu-execution-flow)
6. [Testbench Operation](#testbench-operation)
7. [Complete Execution Example](#complete-execution-example)
8. [Timing Diagrams](#timing-diagrams)
9. [Instruction Execution Results](#instruction-execution-results)

---

## System Overview

### Block Diagram
```
┌─────────────────────────────────────────────────────────┐
│                      cpu_tb (Testbench)                  │
│  ┌───────────────────────────────────────────────────┐  │
│  │              cpu_top (Top Level)                  │  │
│  │                                                   │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌────────┐ │  │
│  │  │ instruction  │  │     data     │  │  CPU   │ │  │
│  │  │   memory     │  │   memory     │  │  FSM   │ │  │
│  │  │  (10-bit)    │  │   (8-bit)    │  │        │ │  │
│  │  └──────────────┘  └──────────────┘  └────────┘ │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Component Hierarchy
```
cpu_tb                          (Testbench - controls and verifies)
  └── cpu_top                   (Top-level integration)
       ├── uut_instr_mem        (Instruction Memory instance)
       ├── uut_data_mem         (Data Memory instance)
       └── uut_cpu              (CPU instance)
```

---

## Memory Architecture

### Instruction Memory (`instruction_memory.v`)

**Purpose**: Stores the program (instructions) that the CPU executes.

**Characteristics**:
- **Width**: 10 bits per instruction
- **Depth**: 8 locations (addresses 0-7)
- **Access**: Read-only (CPU cannot write to it)
- **Type**: Synchronous (registered read)

**Instruction Format (10 bits)**:
```
Bit Position:  9  8  7  |  6  5  4  |  3  2  1  |  0
               [  RES  ] [ OP2  ] [ OP1  ] [OP]
               
OP  (bit 0)     : Operation code (0=ADD, 1=NOT)
OP1 (bits 3:1)  : Address of first operand in data memory
OP2 (bits 6:4)  : Address of second operand in data memory
RES (bits 9:7)  : Address where result will be stored in data memory
```

**Memory Structure**:
```verilog
module instruction_memory (
    input clk,
    input rstn,
    input rd_en,                    // Read enable
    input [2:0] addr,               // Address (0-7)
    output reg [9:0] data_out       // 10-bit instruction
);
    reg [9:0] mem [0:7];            // 8 locations, 10 bits each
    
    // Synchronous read - data appears NEXT clock cycle after request
    always @(posedge clk) begin
        if (rd_en) begin
            data_out <= mem[addr];
        end
    end
endmodule
```

**Key Point**: When the CPU requests an instruction at address `N` on clock cycle `T`, 
the instruction data becomes available on the `data_out` port at clock cycle `T+1`.

### Data Memory (`data_memory.v`)

**Purpose**: Stores operands (input data) and results (output data).

**Characteristics**:
- **Width**: 8 bits per data word
- **Depth**: 8 locations (addresses 0-7)
- **Access**: Read/Write
- **Type**: Dual-port read, dual-port write, synchronous

**Memory Structure**:
```verilog
module data_memory (
    input clk,
    input rstn,
    // Write ports (2 ports - can write to 2 locations simultaneously)
    input wr_en1, wr_en2,
    input [2:0] wr_addr1, wr_addr2,
    input [7:0] data_in1, data_in2,
    
    // Read ports (2 ports - can read 2 locations simultaneously)
    input rd_en1, rd_en2,
    input [2:0] rd_addr1, rd_addr2,
    output reg [7:0] data_out1, data_out2
);
    reg [7:0] mem [0:7];            // 8 locations, 8 bits each
    
    // Synchronous writes
    always @(posedge clk) begin
        if (wr_en1) mem[wr_addr1] <= data_in1;
    end
    
    always @(posedge clk) begin
        if (wr_en2) mem[wr_addr2] <= data_in2;
    end
    
    // Synchronous reads - data appears NEXT clock cycle
    always @(posedge clk) begin
        if (rd_en1) data_out1 <= mem[rd_addr1];
    end
    
    always @(posedge clk) begin
        if (rd_en2) data_out2 <= mem[rd_addr2];
    end
endmodule
```

**Key Point**: The dual-port feature allows the CPU to read both operands 
(operand1 and operand2) in the same clock cycle, improving performance.

---

## How Instruction Memory Works

### 1. Memory Initialization (in Testbench)

The testbench **directly accesses** the memory array to load instructions:

```verilog
// In cpu_tb.v, initial block:
// Access path: uut (cpu_top) . uut_instr_mem (instruction_memory) . mem (array)
uut.uut_instr_mem.mem[0] = 10'b0100010000;  // Instruction at PC=0
uut.uut_instr_mem.mem[1] = 10'b0110010100;  // Instruction at PC=1
// ... and so on
```

**Why this works**: 
- Verilog allows hierarchical access to signals/registers in a module
- The memory array `mem` is declared as `reg [9:0] mem [0:7]` in the module
- Testbench can directly write to it before simulation starts

### 2. CPU Reading Instructions

**Step-by-step process**:

```
Clock Cycle N (FETCH State):
├─ CPU asserts: instr_mem_rd_en = 1
├─ CPU provides: instr_mem_addr = pc (current program counter)
└─ Instruction memory sees the request

Clock Cycle N+1 (DEC State):
├─ Instruction memory outputs: instr_mem_data_out = mem[pc]
├─ CPU receives the 10-bit instruction
└─ CPU decodes: opCode, op1, op2, res from the instruction bits
```

**Example**: Fetching instruction at PC=0
```
PC = 0
Instruction memory content at address 0: 10'b0100010000

Decode:
├─ Bit [0]    = 0   → opCode = ADD
├─ Bits [3:1] = 000 → op1 = 0 (read from data_mem[0])
├─ Bits [6:4] = 001 → op2 = 1 (read from data_mem[1])
└─ Bits [9:7] = 010 → res = 2 (write to data_mem[2])

Meaning: ADD data_mem[0] + data_mem[1] → data_mem[2]
```

---

## How Data Memory Works

### 1. Memory Initialization (in Testbench)

Similar to instruction memory, the testbench directly initializes data:

```verilog
// In cpu_tb.v, initial block:
uut.uut_data_mem.mem[0] = 8'd5;   // Store value 5 at address 0
uut.uut_data_mem.mem[1] = 8'd3;   // Store value 3 at address 1
uut.uut_data_mem.mem[2] = 8'd0;   // Initialize rest to 0
// ... and so on
```

### 2. CPU Reading Data (Dual-Port Read)

**Step-by-step process**:

```
Clock Cycle N (LOAD_OP State):
├─ CPU asserts: data_mem_rd_en1 = 1, data_mem_rd_en2 = 1
├─ CPU provides: rd_addr1 = op1, rd_addr2 = op2
└─ Data memory sees both read requests

Clock Cycle N+1 (LOAD_WAIT State):
├─ Data memory outputs: data_out1 = mem[op1], data_out2 = mem[op2]
├─ CPU waits for data to stabilize
└─ (This is the crucial wait state for synchronous memory!)

Clock Cycle N+2 (EXEC State):
├─ CPU captures: operand1 = data_out1, operand2 = data_out2
├─ CPU performs operation (ADD or NOT)
└─ CPU stores result internally
```

**Example**: Reading operands for first instruction
```
Instruction: ADD data[0] + data[1] → data[2]
op1 = 0, op2 = 1

LOAD_OP State:
├─ Request read from address 0 (port 1)
└─ Request read from address 1 (port 2)

LOAD_WAIT State:
├─ data_out1 becomes mem[0] = 5
└─ data_out2 becomes mem[1] = 3

EXEC State:
├─ operand1 = 5
├─ operand2 = 3
└─ result = 5 + 3 = 8
```

### 3. CPU Writing Data

**Step-by-step process**:

```
Clock Cycle N (WRITE_BACK State):
├─ CPU asserts: data_mem_wr_en1 = 1
├─ CPU provides: wr_addr1 = res (destination address)
├─ CPU provides: data_in1 = result (computed value)
└─ Data memory sees the write request

Clock Cycle N+1:
├─ Data memory writes: mem[res] = result
└─ Data is now permanently stored in memory
```

**Example**: Writing result of first instruction
```
Result from EXEC: 8
Destination: res = 2

WRITE_BACK State:
├─ wr_en1 = 1
├─ wr_addr1 = 2
└─ data_in1 = 8

Next Clock:
└─ mem[2] = 8 (stored!)
```

---

## CPU Execution Flow

### State Machine

The CPU operates as a Finite State Machine (FSM) with 7 states:

```
┌──────┐ start=1  ┌───────┐           ┌──────┐
│ IDLE │─────────→│ FETCH │──────────→│ DEC  │
└──────┘          └───────┘           └──────┘
    ↑                                     │
    │                                     ↓
    │                                ┌─────────┐
    │                                │ LOAD_OP │
    │                                └─────────┘
    │                                     │
    │                                     ↓
    │  done=1                      ┌───────────┐
    │ (PC=7)                       │ LOAD_WAIT │
    │                              └───────────┘
    │                                     │
    │                                     ↓
┌────────────┐                       ┌──────┐
│ WRITE_BACK │←──────────────────────│ EXEC │
└────────────┘                       └──────┘
     │
     └───→ (PC < 7) ───→ FETCH (next instruction)
```

### State-by-State Breakdown

#### State 0: IDLE
```
Waiting for start signal
├─ done = 0
├─ All outputs inactive
└─ When start=1: go to FETCH, pc=0
```

#### State 1: FETCH
```
Request instruction from instruction memory
├─ Output: instr_mem_rd_en = 1
├─ Output: instr_mem_addr = pc
├─ Next state: DEC
└─ Purpose: Issue read request (data arrives next cycle)
```

#### State 2: DEC (Decode)
```
Receive and decode instruction
├─ Input: instr_mem_data_out (10 bits)
├─ Decode: opCode = bit[0]
├─ Decode: op1 = bits[3:1]
├─ Decode: op2 = bits[6:4]
├─ Decode: res = bits[9:7]
├─ Next state: LOAD_OP
└─ Purpose: Extract instruction fields
```

#### State 3: LOAD_OP
```
Request operands from data memory
├─ Output: data_mem_rd_en1 = 1
├─ Output: data_mem_rd_en2 = 1
├─ Output: rd_addr1 = op1
├─ Output: rd_addr2 = op2
├─ Next state: LOAD_WAIT
└─ Purpose: Issue dual read request
```

#### State 4: LOAD_WAIT
```
Wait for data memory read latency
├─ Keep read enables active
├─ Data becomes valid this cycle
├─ Next state: EXEC
└─ Purpose: Account for synchronous memory delay
```

#### State 5: EXEC (Execute)
```
Capture operands and perform operation
├─ Capture: operand1 = data_out1
├─ Capture: operand2 = data_out2
├─ Compute: if (opCode == 0) result = operand1 + operand2
│           else result = ~operand1
├─ Next state: WRITE_BACK
└─ Purpose: Perform ALU operation
```

#### State 6: WRITE_BACK
```
Write result to data memory
├─ Output: data_mem_wr_en1 = 1
├─ Output: wr_addr1 = res
├─ Output: data_in1 = result
├─ If (pc == 7): done=1, go to IDLE
├─ Else: pc++, go to FETCH
└─ Purpose: Store result and advance program
```

### Complete Instruction Execution Timeline

```
Cycle  State        Action
────────────────────────────────────────────────────────────
  1    FETCH        Request instruction from mem[PC]
  2    DEC          Receive & decode instruction
  3    LOAD_OP      Request operand1 from mem[op1], operand2 from mem[op2]
  4    LOAD_WAIT    Wait for data (arrives at end of cycle)
  5    EXEC         Capture operands, compute result
  6    WRITE_BACK   Write result to mem[res], PC++
  7    FETCH        Request next instruction...
```

**Total: 6 cycles per instruction**

---

## Testbench Operation

### Complete Flow

```
1. INITIALIZATION PHASE
   ├─ Clock starts running (automatic)
   ├─ Reset asserted (rstn = 0)
   ├─ Load instruction memory with program
   ├─ Load data memory with initial values
   └─ Display initial state

2. RESET RELEASE
   ├─ De-assert reset (rstn = 1)
   └─ CPU enters IDLE state

3. START EXECUTION
   ├─ Assert start signal (start = 1 for 1 cycle)
   └─ CPU begins executing from PC=0

4. EXECUTION PHASE
   ├─ CPU executes all 8 instructions
   ├─ Monitor prints state changes
   └─ Wait for done signal

5. VERIFICATION PHASE
   ├─ Read final data memory values
   ├─ Compare with expected results
   └─ Display PASS/FAIL for each

6. FINISH
   └─ $finish terminates simulation
```

### Memory Initialization Explained

**Question**: How does the testbench put values into memory?

**Answer**: Through **hierarchical access**:

```verilog
// Testbench hierarchy:
cpu_tb                              // Testbench module
  └── uut (cpu_top instance)        // Top-level design
       ├── uut_instr_mem            // Instruction memory instance
       │    └── mem[0:7]            // Actual memory array
       └── uut_data_mem             // Data memory instance
            └── mem[0:7]            // Actual memory array

// Accessing memory from testbench:
uut.uut_instr_mem.mem[0] = 10'b0100010000;
 │        │         │    └─ Memory array element
 │        │         └────── Memory array name
 │        └──────────────── Instance name in cpu_top
 └───────────────────────── Instance name in testbench
```

**This works because**:
- Verilog allows modules to access internal signals of other modules hierarchically
- Memory arrays are just registers, so they can be written directly
- This is done in the `initial` block, which runs once at simulation start

### Self-Checking Mechanism

The testbench is "self-checking" because it automatically verifies results:

```verilog
// Step 1: Define expected values
expected[0] = 10;   // After instruction 7 executes
expected[1] = 3;    // Unchanged
expected[2] = 8;    // After instruction 0 executes
// ... etc

// Step 2: Read actual values from memory
actual[0] = uut.uut_data_mem.mem[0];

// Step 3: Compare and report
if (actual[0] == expected[0]) 
    $display("PASS");
else 
    $display("FAIL");
```

**The testbench knows what to expect because**:
1. It knows the initial data values (it loaded them)
2. It knows the instructions (it loaded them)
3. It can compute expected results manually
4. It compares computed expectations vs. actual results

---

## Complete Execution Example

Let's trace the **first instruction** through the entire system:

### Initial Setup
```
Instruction Memory[0] = 10'b0100010000
Data Memory[0] = 5
Data Memory[1] = 3
Data Memory[2] = 0
PC = 0
```

### Cycle-by-Cycle Execution

#### **Cycle 1: FETCH**
```
State: FETCH
CPU Outputs:
  instr_mem_addr = 0
  instr_mem_rd_en = 1

Instruction Memory Action:
  Sees read request for address 0
  Prepares to output mem[0] next cycle

Result: Read request issued
```

#### **Cycle 2: DEC**
```
State: DEC
CPU Inputs:
  instr_mem_data_out = 10'b0100010000

CPU Decoding:
  opCode = bit[0] = 0 → ADD operation
  op1 = bits[3:1] = 000 = 0 → first operand at data_mem[0]
  op2 = bits[6:4] = 001 = 1 → second operand at data_mem[1]
  res = bits[9:7] = 010 = 2 → result goes to data_mem[2]

Internal Registers Updated:
  opCode <= 0
  op1 <= 0
  op2 <= 1
  res <= 2

Result: Instruction decoded as "ADD data[0] + data[1] → data[2]"
```

#### **Cycle 3: LOAD_OP**
```
State: LOAD_OP
CPU Outputs:
  data_mem_rd_en1 = 1
  data_mem_rd_en2 = 1
  rd_addr1 = 0
  rd_addr2 = 1

Data Memory Action:
  Port 1: Sees read request for address 0
  Port 2: Sees read request for address 1
  Prepares to output both values next cycle

Result: Dual read request issued
```

#### **Cycle 4: LOAD_WAIT**
```
State: LOAD_WAIT
CPU Inputs:
  data_out1 = mem[0] = 5
  data_out2 = mem[1] = 3

CPU Action:
  Waits for data to stabilize (synchronous read delay)
  Keeps read enables active

Result: Valid data now available on outputs
```

#### **Cycle 5: EXEC**
```
State: EXEC
CPU Action:
  operand1 <= data_out1 = 5
  operand2 <= data_out2 = 3
  
  ALU Operation (opCode = 0, so ADD):
    result <= operand1 + operand2
    result <= 5 + 3
    result <= 8

Internal Registers Updated:
  operand1 <= 5
  operand2 <= 3
  result <= 8

Result: Computation complete, result = 8
```

#### **Cycle 6: WRITE_BACK**
```
State: WRITE_BACK
CPU Outputs:
  data_mem_wr_en1 = 1
  wr_addr1 = 2
  data_in1 = 8

Data Memory Action:
  Sees write request
  mem[2] <= 8

CPU Action:
  PC = 0 (not equal to 7, so continue)
  pc <= pc + 1 = 1
  state <= FETCH

Result: Result written to data_mem[2], move to next instruction
```

### After First Instruction
```
Data Memory Updated:
  mem[0] = 5  (unchanged)
  mem[1] = 3  (unchanged)
  mem[2] = 8  (UPDATED! was 0, now 8)
  
PC Updated:
  PC = 1 (ready for next instruction)

Next: CPU will fetch instruction at PC=1 and repeat the cycle
```

---

## Timing Diagrams

### Clock and Control Signals
```
Clock:    ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐
          │  │  │  │  │  │  │  │  │  │  │  │  │  │
        ──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──
Cycle:     1     2     3     4     5     6     7

State:   FETCH  DEC  LOAD WAIT  EXEC WBACK FETCH
                      _OP

PC:        0     0     0     0     0     0     1
```

### Instruction Memory Read Timing
```
Clock:    ┌──┐  ┌──┐  ┌──┐
          │  │  │  │  │  │
        ──┘  └──┘  └──┘  └──
Cycle:     1     2     3

rd_en:    ────┐___________
              └─────

addr:     ──< 0 >─────────

data_out: ──────< INST >──
          [invalid] [valid]
                    ↑
            Data available here (1 cycle delay)
```

### Data Memory Read Timing (Dual-Port)
```
Clock:    ┌──┐  ┌──┐  ┌──┐  ┌──┐
          │  │  │  │  │  │  │  │
        ──┘  └──┘  └──┘  └──┘  └──
Cycle:     3     4     5

rd_en1:   ────┐_________________
              └───────

rd_addr1: ──< 0 >───────────────

data_out1:──────────< 5 >───────
          [invalid]  [valid]

rd_en2:   ────┐_________________
              └───────

rd_addr2: ──< 1 >───────────────

data_out2:──────────< 3 >───────
          [invalid]  [valid]
                     ↑
         Both operands available here
```

### Data Memory Write Timing
```
Clock:    ┌──┐  ┌──┐
          │  │  │  │
        ──┘  └──┘  └──
Cycle:     6     7

wr_en1:   ────┐_____
              └───

wr_addr1: ──< 2 >───

data_in1: ──< 8 >───

mem[2]:   ──< 0 >< 8 >
               ↑    ↑
         [old] │    │[new]
               │    └── Written here
               └─────── Still old value
```

---

## Summary: How It All Works Together

### 1. **Before Simulation Starts**
- Testbench loads program into instruction memory array
- Testbench loads initial data into data memory array
- These are done via direct hierarchical access to internal arrays

### 2. **During Simulation**
- CPU executes instructions one by one using FSM states
- Each instruction takes 6 clock cycles to complete
- CPU reads from instruction memory (what to do)
- CPU reads from data memory (operands)
- CPU performs operation (ADD or NOT)
- CPU writes to data memory (results)

### 3. **Key Memory Concepts**
- **Synchronous memory** = 1-cycle delay from request to data
- **Dual-port read** = can read 2 addresses simultaneously
- **Direct array access** = testbench can read/write memory arrays directly

### 4. **Self-Checking**
- Testbench knows initial values (it loaded them)
- Testbench knows instructions (it loaded them)
- Testbench computes expected results
- After execution, testbench compares actual vs expected
- Reports PASS/FAIL automatically

### 5. **Why LOAD_WAIT is Crucial**
- Memory reads are synchronous (registered)
- Request on cycle N → Data valid on cycle N+1
- LOAD_WAIT gives memory time to output valid data
- Without it, CPU would capture invalid/stale data

This design demonstrates a Harvard architecture CPU with proper memory timing, 
dual-port optimization, and comprehensive self-checking testbench methodology.

---

## Instruction Execution Results

This section shows the complete instruction set execution with data memory state after each instruction.

### Initial Data Memory State

Before any instructions execute:

```
Address  │  Value  │  Description
─────────┼─────────┼──────────────────────
   0     │    5    │  Initial operand
   1     │    3    │  Initial operand
   2     │    0    │  Uninitialized
   3     │    0    │  Uninitialized
   4     │    0    │  Uninitialized
   5     │    0    │  Uninitialized
   6     │    0    │  Uninitialized
   7     │    0    │  Uninitialized
```

### Instruction-by-Instruction Execution

---

#### **Instruction 0** (PC=0): `ADD data[0] + data[1] → data[2]`

**Binary**: `10'b0100010000`

**Decode**:
- Opcode (bit 0): `0` = ADD
- Op1 (bits 3:1): `000` = 0 (address in data memory)
- Op2 (bits 6:4): `001` = 1 (address in data memory)
- Res (bits 9:7): `010` = 2 (destination address)

**Execution**:
```
Read:     data[0] = 5, data[1] = 3
Compute:  5 + 3 = 8
Write:    data[2] = 8
```

**Data Memory After Instruction 0**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  ← UPDATED (was 0)
   3     │    0    │  
   4     │    0    │  
   5     │    0    │  
   6     │    0    │  
   7     │    0    │  
```

---

#### **Instruction 1** (PC=1): `ADD data[2] + data[1] → data[3]`

**Binary**: `10'b0110010100`

**Decode**:
- Opcode: `0` = ADD
- Op1: `010` = 2
- Op2: `001` = 1
- Res: `011` = 3

**Execution**:
```
Read:     data[2] = 8, data[1] = 3
Compute:  8 + 3 = 11
Write:    data[3] = 11
```

**Data Memory After Instruction 1**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  ← UPDATED (was 0)
   4     │    0    │  
   5     │    0    │  
   6     │    0    │  
   7     │    0    │  
```

---

#### **Instruction 2** (PC=2): `NOT ~data[2] → data[4]`

**Binary**: `10'b1000000101`

**Decode**:
- Opcode: `1` = NOT
- Op1: `010` = 2
- Op2: `000` = 0 (unused for NOT operation)
- Res: `100` = 4

**Execution**:
```
Read:     data[2] = 8 (00001000 in binary)
Compute:  ~8 = 247 (11110111 in binary)
Write:    data[4] = 247
```

**Data Memory After Instruction 2**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  
   4     │  247    │  ← UPDATED (was 0)
   5     │    0    │  
   6     │    0    │  
   7     │    0    │  
```

---

#### **Instruction 3** (PC=3): `ADD data[3] + data[4] → data[5]`

**Binary**: `10'b1011000110`

**Decode**:
- Opcode: `0` = ADD
- Op1: `011` = 3
- Op2: `100` = 4
- Res: `101` = 5

**Execution**:
```
Read:     data[3] = 11, data[4] = 247
Compute:  11 + 247 = 258
          258 mod 256 = 2 (8-bit overflow)
Write:    data[5] = 2
```

**Note**: 8-bit arithmetic wraps around. 258 = 0x102, truncated to 8 bits = 0x02 = 2

**Data Memory After Instruction 3**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  
   4     │  247    │  
   5     │    2    │  ← UPDATED (was 0, overflow result)
   6     │    0    │  
   7     │    0    │  
```

---

#### **Instruction 4** (PC=4): `NOT ~data[5] → data[6]`

**Binary**: `10'b1100001011`

**Decode**:
- Opcode: `1` = NOT
- Op1: `101` = 5
- Op2: `000` = 0 (unused)
- Res: `110` = 6

**Execution**:
```
Read:     data[5] = 2 (00000010 in binary)
Compute:  ~2 = 253 (11111101 in binary)
Write:    data[6] = 253
```

**Data Memory After Instruction 4**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  
   4     │  247    │  
   5     │    2    │  
   6     │  253    │  ← UPDATED (was 0)
   7     │    0    │  
```

---

#### **Instruction 5** (PC=5): `ADD data[0] + data[0] → data[7]`

**Binary**: `10'b1110000000`

**Decode**:
- Opcode: `0` = ADD
- Op1: `000` = 0
- Op2: `000` = 0 (same address, reads same value twice)
- Res: `111` = 7

**Execution**:
```
Read:     data[0] = 5, data[0] = 5 (dual-port reads same location)
Compute:  5 + 5 = 10
Write:    data[7] = 10
```

**Data Memory After Instruction 5**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  
   4     │  247    │  
   5     │    2    │  
   6     │  253    │  
   7     │   10    │  ← UPDATED (was 0)
```

---

#### **Instruction 6** (PC=6): `ADD data[7] + data[7] → data[7]`

**Binary**: `10'b1111111110`

**Decode**:
- Opcode: `0` = ADD
- Op1: `111` = 7
- Op2: `111` = 7
- Res: `111` = 7 (reads and writes same location!)

**Execution**:
```
Read:     data[7] = 10, data[7] = 10
Compute:  10 + 10 = 20
Write:    data[7] = 20 (overwrites itself)
```

**Data Memory After Instruction 6**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │    5    │  
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  
   4     │  247    │  
   5     │    2    │  
   6     │  253    │  
   7     │   20    │  ← UPDATED (was 10, doubled itself)
```

---

#### **Instruction 7** (PC=7): `ADD data[0] + data[0] → data[0]`

**Binary**: `10'b0000000000`

**Decode**:
- Opcode: `0` = ADD
- Op1: `000` = 0
- Op2: `000` = 0
- Res: `000` = 0 (reads and writes same location!)

**Execution**:
```
Read:     data[0] = 5, data[0] = 5
Compute:  5 + 5 = 10
Write:    data[0] = 10 (overwrites itself)
```

**Data Memory After Instruction 7 (FINAL STATE)**:
```
Address  │  Value  │  Change
─────────┼─────────┼──────────
   0     │   10    │  ← UPDATED (was 5, doubled itself)
   1     │    3    │  
   2     │    8    │  
   3     │   11    │  
   4     │  247    │  
   5     │    2    │  
   6     │  253    │  
   7     │   20    │  
```

---

### Summary Table: All Instructions and Results

| PC | Instruction | Binary Code | Operation | Operands | Result | Written To |
|----|-------------|-------------|-----------|----------|--------|------------|
| 0  | ADD         | 0100010000  | ADD       | 5 + 3    | 8      | data[2]    |
| 1  | ADD         | 0110010100  | ADD       | 8 + 3    | 11     | data[3]    |
| 2  | NOT         | 1000000101  | NOT       | ~8       | 247    | data[4]    |
| 3  | ADD         | 1011000110  | ADD       | 11 + 247 | 2*     | data[5]    |
| 4  | NOT         | 1100001011  | NOT       | ~2       | 253    | data[6]    |
| 5  | ADD         | 1110000000  | ADD       | 5 + 5    | 10     | data[7]    |
| 6  | ADD         | 1111111110  | ADD       | 10 + 10  | 20     | data[7]    |
| 7  | ADD         | 0000000000  | ADD       | 5 + 5    | 10     | data[0]    |

*Note: Result 2 from instruction 3 is due to 8-bit overflow (258 mod 256 = 2)

### Memory State Comparison

```
                INITIAL STATE    →    FINAL STATE
              ┌─────────────┐        ┌─────────────┐
Address 0     │      5      │   →    │     10      │  (doubled by instr 7)
Address 1     │      3      │   →    │      3      │  (unchanged)
Address 2     │      0      │   →    │      8      │  (5+3, instr 0)
Address 3     │      0      │   →    │     11      │  (8+3, instr 1)
Address 4     │      0      │   →    │    247      │  (~8, instr 2)
Address 5     │      0      │   →    │      2      │  (11+247 overflow, instr 3)
Address 6     │      0      │   →    │    253      │  (~2, instr 4)
Address 7     │      0      │   →    │     20      │  (5+5→10→20, instr 5&6)
              └─────────────┘        └─────────────┘
```

### Total Execution Statistics

- **Total Instructions Executed**: 8
- **Total Clock Cycles**: 48 (6 cycles per instruction)
- **Memory Writes**: 8 (one per instruction)
- **Memory Reads**: 16 (two per instruction, dual-port)
- **ADD Operations**: 6
- **NOT Operations**: 2
- **Data Dependencies**: 
  - Instruction 1 depends on Instruction 0 (uses data[2])
  - Instruction 3 depends on Instructions 1 & 2 (uses data[3] & data[4])
  - Instruction 4 depends on Instruction 3 (uses data[5])
  - Instruction 6 depends on Instruction 5 (uses data[7])
  - Instruction 7 modifies data[0] (original input)

### Verification Results

All testbench assertions **PASS** ✅:

```
Address 0:  Expected 10   Got 10   ✓ PASS
Address 1:  Expected 3    Got 3    ✓ PASS
Address 2:  Expected 8    Got 8    ✓ PASS
Address 3:  Expected 11   Got 11   ✓ PASS
Address 4:  Expected 247  Got 247  ✓ PASS
Address 5:  Expected 2    Got 2    ✓ PASS
Address 6:  Expected 253  Got 253  ✓ PASS
Address 7:  Expected 20   Got 20   ✓ PASS

=== TEST SUMMARY: ALL TESTS PASSED! ===
```

This completes the full execution trace showing how each instruction modifies 
the data memory and how the final state is verified by the testbench.

