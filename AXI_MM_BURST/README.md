# AXI4 Slave with Integrated ALU

## Overview
AXI4 slave module with integrated ALU that computes results during write transactions. The ALU automatically processes operations and stores results in byte-addressable memory.

## Key Features
- **Integrated ALU**: Computes during write (no extra cycles)
- **4-byte operation format**: op1, op2, opcode, result
- **Burst transfers**: Variable length (1-16 beats)
- **Byte-addressable memory**: 8-bit words, 1024 bytes

## Data Format

Each 4-byte write represents one ALU operation:

| Byte | Offset | Content | Description |
|------|--------|---------|-------------|
| 0 | base+0 | op1 | First operand |
| 1 | base+1 | op2 | Second operand |
| 2 | base+2 | opcode | Operation code |
| 3 | base+3 | **result** | **ALU computed result** |

## ALU Operations

| Opcode | Operation | Example |
|--------|-----------|---------|
| 0 | ADD | 5 + 3 = 8 |
| 1 | SUB | 10 - 4 = 6 |
| 2 | NOT | ~15 = 240 |
| 3 | SHL | 2 << 3 = 16 |

## Files

| File | Description |
|------|-------------|
| `cpu.sv` | AXI slave with ALU integration |
| `alu.v` | 8-bit ALU module |
| `memory.v` | Byte-addressable memory |
| `cpu_tb.v` | Testbench with 5 ALU tests |
| `simulate.sh` | Run simulation |

## Quick Start

```bash
bash simulate.sh
```

## Example Operation

**Write:** Send 4 bytes to address 0x00
- Byte 0: op1 = 5
- Byte 1: op2 = 3
- Byte 2: opcode = 0 (ADD)
- Byte 3: (dummy - ignored)

**Result:** Memory[0x03] = 8 (computed by ALU)

**Read:** Read from address 0x03 returns 8

## Test Results

```
=== AXI ALU Operation Tests ===
TEST 1: 5 + 3 = 8    PASS
TEST 2: 10 - 4 = 6   PASS
TEST 3: ~15 = 240    PASS
TEST 4: 2 << 3 = 16  PASS
TEST 5: 20 + 7 = 27  PASS
```

## How It Works

1. Master sends 4-byte write burst
2. CPU captures byte 0 → op1
3. CPU captures byte 1 → op2
4. CPU captures byte 2 → opcode
5. **ALU computes result instantly**
6. CPU writes ALU result to byte 3 (not master data!)
7. Result stored in memory for later read

## Performance

- **Write latency**: 5 cycles (4 data + 1 response)
- **Computation**: 0 cycles (combinational ALU)
- **Read latency**: 2 cycles per byte

---
**Status:**  Tested & Working
