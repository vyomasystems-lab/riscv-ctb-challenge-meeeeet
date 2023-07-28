# Challenge Level-3

## Table of Contents:
- [Bug Finding Challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level3#bug-finding-challenge)
    - [Verification Strategy](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/edit/main/challenge_level3/README.md#verification-strategy)
    - [1st Bug](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level3#1st-bug-or-instruction)
    - [2nd Bug](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level3#2nd-bug-ori-instruction)
    - [Tool error](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level3#tool-error)
- [Coverage challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level3#coverage-challenge)
## Bug Finding Challenge

### Verification Strategy:

1) **Randomized Instruction Test:** Ran a large number of randomized instructions to stress-test the buggy design and identify potential issues.

2) **Comparison with Reference Model:** Extracted opcode values for specific instructions causing differences between `rtl.dump` and `spike.dump`. Observed the type and operation of these instructions from the `test.disass` file generated during Spike simulation.

3) **Directed Testing:** Devised directed tests for the identified instructions, aiming to replicate scenarios where discrepancies occurred. Manually verified the directed tests against expected output.

4) **Comparison with Dump Files:** Compared outputs of the directed tests with `rtl.dump` and `spike.dump` files to confirm the correctness of the identified bug and ensure consistent results.

### 1st Bug: `OR` instruction

- The first bug is in `OR` instruction.
- If two same number is give as operand of `OR` then rather than producing output that same as input it is producing 0x00000000.
- Also, it is not working properly with two unique operands.
- Directed test:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/6ab07901-eea4-4dff-9eda-a95d0caf5d23)
- Comparision between `rtl.dump` and `spike.dump`:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/e4b5029b-b589-4897-ae9b-23e14158fd46)

  | Register | rtl.dump | spike.dump |
  |------|-------|--------|
  | x20 | 0x00000000 | 0x12345678 |
  | x21 | 0x1f2003ff | 0x1f2ff3ff |
  | x22 | 0xb0cfdffe | 0xbfcfdffe |
  | x23 | 0x11badcfe | 0x11bbddff |
- Expected result:
  
  | Register | Data |
  |------|-------|
  | x20 | 0x12345678 |
  | x21 | 0x1f2ff3ff |
  | x22 | 0xbfcfdffe |
  | x23 | 0x11bbddff |


- From comparision, the output values in rtl.dump is wrong, hence instruction `OR` is buggy.

### 2nd Bug: `ORI` instruction

- `ORI` instruction is performing xor operation insted of or operation.
- Directed Test:
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/e063fc86-b6cd-4e36-8ac0-44c82c6b874b)

- Comparision between `rtl.dump` and `spike.dump`:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/359dd962-78c5-4e74-85a3-9ef6eb250c38)

  | Register | rtl.dump | spike.dump |
  |------|-------|--------|
  | x20 | 0x000001ff | 0x000001ff |
  | x21 | 0x0000017e | 0x0000017f |
  | x22 | 0x00000000 | 0x00000101 |
  | x23 | 0x0000002f | 0x000007ff |
- Expected result:
  
  | Register | Data |
  |------|-------|
  | x20 | 0x000001ff |
  | x21 | 0x0000017f |
  | x22 | 0x00000101 |
  | x23 | 0x000007ff |


- By looking at comparision in between both dump file, we can conclude that `spike.dump` is accurate than `rtl.dump` and `ori` instruction is doing xor operation. Hence it is buggy instruction.

### Tool Error
- As explained in previous section, OR and ORI are buggy instructions.
- While runnig AAPG random instruction generator, in which if one of the buggy instruction are executed before non-buggy instruction then the output produced by non-buggy instrucion may different from actual output.
- Random Test:
  Config file for random test:
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/8ee0c4d4-276c-4196-bd96-6853a20eda46)

  Results:
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/fca34c4d-212a-4fcb-a87a-03b26ccf2df5)
- In this results of random test, we can see that `xor` is observed as buggy instruction even though it is valid one.
- This case can be observed by this directed test code:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/00519995-75a9-42a7-886c-f48a35df6f79)
- In this case, result of `or` and `ori` is use as input to other instructions.
- Comparision between `rtl.dump` and `spike.dump`:
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/5c4026d9-96e5-460d-a575-106f74e22f34)
- Expected result:
  | Register | Data |
  |------|-------|
  | x20 | 0x11111111 |
  | x21 | 0x33333333 |
  | x22 | 0x01010101 |
  | x23 | 0x11111111 |

- As we can see in result of spike simulation, buggy result produced by buggy instruction can affect result of valid instruction.

### Now, how to verify functionality of other instructions?
- In order to test all instructions without using buggy instructions in anywhere in test code, what we can do is remove those buggy instructions from source code of AAPG.
- Which can be done by commenting `or` and `ori` instructions in section of `rv32i.compute` in content of `isa_funcs.py` file.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/16dc1ffe-b389-4371-9a52-4b97f6c11987)
- This `isa_funcs.py` is located at `/usr/local/lib/python3.8/site-packages/aapg/isa_funcs.py` of codespace.
- Because of this modification AAPG will not generate those buggy instructions in random generator and other instructions can be properly verify.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/616e6563-5470-4775-8680-21ff56b2c00a)
- Here, there is only 2 bugs in given design, that's why there will be no difference in dump files after modification.




## Coverage Challenge
- In this challenge, in order to generate coverge report of design a `cov` file must be executed after `run` file.
- For simplicity in generating code coverage one [`Makefile`](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level3/riscv_dv_coverage/Makefile) is created which include execution of `run` and `cov` files.
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/747ae113-cf65-4a12-932c-a837f88957a1)


- Using this file, code coverage can be generated by executing [`Makefile`](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level3/riscv_dv_coverage/Makefile).
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/ba1b7176-43da-4603-ab2b-c83992226b87)


