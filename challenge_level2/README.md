# Challenge Level-2
## Table of Contents
  - [Instructions Challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level2#instructions-challenge])
  - [Exception Challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/tree/main/challenge_level2#exception-challenge)
## Instructions Challenge
### Bug:
- In this config gile AAPG, the value of ```rel_rv64m``` is set on 10, that means
  some of the generated instructions will be RV64M type.
- Because of that AAPG generating some RV64M instructions that is throwing an error.

### Corrections:
```
  rel_rv64m: 0
```

## Exception Challenge
- **Challenge:** Create a AAPG config file to generate a test with 10 illegal exceptions.
- **Solution:** By giving a non-zero value in ```exception-generation:```, we can generate any number of exceptions.
- In [my config](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level2/challenge2_exceptions/rv32i.yaml), I have set ```total_instructions``` to 10000 as well as ```ecause00 to ecause09``` to 5.
- By using this value in config we can get 10 exceptions.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/7b17539d-b967-4003-aa8b-b62c20ade626)
### Generated Exceptions:
```
core   0: exception trap_illegal_instruction, epc 0x800000b0
core   0: exception trap_illegal_instruction, epc 0x80002a10
core   0: exception trap_illegal_instruction, epc 0x800046e4
core   0: exception trap_illegal_instruction, epc 0x800046ec
core   0: exception trap_illegal_instruction, epc 0x80004ad4
core   0: exception trap_illegal_instruction, epc 0x80005f8c
core   0: exception trap_illegal_instruction, epc 0x800067e0
core   0: exception trap_illegal_instruction, epc 0x800090e8
core   0: exception trap_illegal_instruction, epc 0x800090f0
core   0: exception trap_illegal_instruction, epc 0x8000a148
```



