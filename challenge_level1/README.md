# Challenge_level1
## Table of Contents
- [Logical Challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level1/README.md#logical-challenge)
- [Loop Challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level1/README.md#loop-challenge)
- [Illegal Challenge](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level1/README.md#illegal-challenge)


## Logical Challenge

### 1st Bug

- Invalid register was used: ```and s7, ra, z4```
- **Solution:** Insted of ```z4``` any RV32I register can be used. eg. ```and s7, ra, a4```
  
### 2nd Bug
- Invalid Instruction was used:
    ```andi s5, t1, s0```
- **Solution:** ```and s5, t1, s0```

## Loop Challenge
### Bug:
- In this code loop must be execute 3 times but it is going in infinite loop.
- Because in instructions of loop register ```t5``` isn't decreasing towords 0.
- **Correction:** While comparing ```t3``` and ```t4```, if its correct than it
  should goes to another loop named ```continue_loop``` in which ```t5``` will
  decreased by 1 and loop will continue unless and until ```t5``` becomes to 0.
### Corrected Code:
```
la t0, test_cases
li t5, 3

loop:
  lw t1, (t0)
  lw t2, 4(t0)
  lw t3, 8(t0)
  add t4, t1, t2
  addi t0, t0, 12
  beq t3, t4, continue_loop        # if sum is correct then go to continue_loop
  j fail
continue_loop:
  addi t5, t5, -1         # Decrement the counter
  bnez t5, loop           # If t5 is not zero, continue with the next test case
  j test_end              # If t5 is zero, exit the loop and go to the end of the test
test_end:
```
## Illegal Challenge

### Bug
- In this exception handler, once exception caught it is going on infinite loop.
- Because after executing ```mtvec_handler```, the value of ```mepc``` is not getting incremented.
- **Solution:** By increamenting ```mepc``` by 8 location this bug can be solved.
### Corrected Handler
```
mtvec_handler:
  li t1, CAUSE_ILLEGAL_INSTRUCTION
  csrr t0, mcause
  bne t0, t1, fail
  csrr t0, mepc
  addi t0,t0,8          # +
  csrw mepc, t0         # +
mret
```

