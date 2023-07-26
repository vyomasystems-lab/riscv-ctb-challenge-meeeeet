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

### Side effect of using OR and ORI instruction
- As explained in previous section, OR and ORI are buggy instructions.
- While runnig AAPG random instruction generator, in which if one of the buggy instruction are executed before non-buggy instruction then the output produced by non-buggy instrucion may different from actual output.
- This case can be observed by this test code:
```
# Test-1
  li x10,0x11111111
  li x11,0x22222222
  or x20, x10, x10
  add x21, x11, x20

# Test-2
  li x12,0x01010101
  li x13,0x10101010
  or x22, x12, x12
  xor x23, x22, x13
```
- Expected value of each register after execution:
  
  | Register | Data |
  |------|-------|
  | x20 | 0x11111111 |
  | x21 | 0x33333333 |
  | x22 | 0x01010101 |
  | x23 | 0x11111111 |

- Results after spike simulations

`rtl.dump`      |  `spike.dump`
:-------------------------:|:-------------------------:
![Screenshot 2023-07-26 004710](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/a71e33fc-5a76-41cb-90a8-128a286792e2) | ![Screenshot 2023-07-26 004801](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/ce18e9c8-6394-4bfb-8533-bca788701a6c)

- As we can see in figure output of both are different from each other.
#### Now, how to verify functionality of other instructions?
- In order to test all instructions without using buggy instructions in anywhere in test code, what we can do is remove those buggy instructions from source code of AAPG.
- Which can be done by commenting `or` and `ori` instructions in section of `rv32i.compute` in content of `isa_funcs.py` file.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/16dc1ffe-b389-4371-9a52-4b97f6c11987)
- This `isa_funcs.py` is located at `/usr/local/lib/python3.8/site-packages/aapg/isa_funcs.py` of codespace.
- Because of this modification AAPG will not generate those buggy instructions in random generator and other instructions can be properly verify.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/616e6563-5470-4775-8680-21ff56b2c00a)
- Here, there is only 2 bugs in given design, that's why there will be no difference in dump files after modification.
- 
