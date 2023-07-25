# Challenge Level-3
## Bug Finding Challenge

**Verification Strategy:**

1) **Randomized Instruction Test:** Ran a large number of randomized instructions to stress-test the buggy design and identify potential issues.

2) **Comparison with Reference Model:** Extracted opcode values for specific instructions causing differences between `rtl.dump` and `spike.dump`. Observed the type and operation of these instructions from the `test.disass` file generated during Spike simulation.

3) **Directed Testing:** Devised directed tests for the identified instructions, aiming to replicate scenarios where discrepancies occurred. Manually verified the directed tests against expected output.

4) **Comparison with Dump Files:** Compared outputs of the directed tests with `rtl.dump` and `spike.dump` files to confirm the correctness of the identified bug and ensure consistent results.

### 1st Bug: `OR` instruction

- The first bug is in `OR` instruction.
- If two same number is give as operand of `OR` then rather than producing output that same as input it is producing 0x00000000.
- Also, it is not working properly with two unique operands.
- Directed test:
```
# Test-1
  li a0,0x12345678
  li a1,0x12345678
  or x20, a0, a1
# Test-2
  li a2,0x1f2ff3ff
  li a3,0x000ff000
  or x21, a2, a3
# Test-3
  li a4,0x0f0f0f00
  li a5,0xbfc0d0fe
  or x22, a4, a5
# Test-4
  li a6,0x00abcdef
  li a7,0x11111111
  or x23, a6, a7
```
- Expected result:
  
  | Register | Data |
  |------|-------|
  | x20 | 0x12345678 |
  | x21 | 0x1f2ff3ff |
  | x22 | 0xbfcfdffe |
  | x23 | 0x11bbddff |

- Comparision between `rtl.dump` and `spike.dump`:

  | Register | rtl.dump | spike.dump |
  |------|-------|--------|
  | x20 | 0x00000000 | 0x12345678 |
  | x21 | 0x1f2003ff | 0x1f2ff3ff |
  | x22 | 0xb0cfdffe | 0xbfcfdffe |
  | x23 | 0x11badcfe | 0x11bbddff |
- From comparision, the output values in rtl.dump is wrong, hence instruction `OR` is buggy.

### 2nd Bug: `ORI` instruction

- `ORI` instruction is performing xor operation insted of or operation.
- Directed Test:
```
# Test-1
  li a0,0
  ori x20, a0, 0x000001ff
# Test-2
  li a2, 111
  ori x21, a2, 0x000000111
# Test-3
  li a4,0x00000101
  ori x22, a4, 0x00000101
# Test-4
  li a6, 2000
  ori x23, a6, 0x000007ff
  ```
- Expected result:
  
  | Register | Data |
  |------|-------|
  | x20 | 0x000001ff |
  | x21 | 0x0000017f |
  | x22 | 0x00000101 |
  | x23 | 0x000007ff |

- Comparision between `rtl.dump` and `spike.dump`:

  | Register | rtl.dump | spike.dump |
  |------|-------|--------|
  | x20 | 0x000001ff | 0x000001ff |
  | x21 | 0x0000017e | 0x0000017f |
  | x22 | 0x00000000 | 0x00000101 |
  | x23 | 0x0000002f | 0x000007ff |

- By looking at comparision in between both dump file, we can conclude that `spike.dump` is accurate than `rtl.dump` and `ori` instruction is doing xor operation.


  
