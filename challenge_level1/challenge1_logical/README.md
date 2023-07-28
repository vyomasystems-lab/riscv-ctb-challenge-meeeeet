## Logical Challenge

### Error:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/fc51c0a6-e964-4b25-9539-0f249d32b994)

### 1st Bug:

- Invalid register was used: ```and s7, ra, z4```
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/8725ec7e-0125-4290-b8fc-018a292d06f2)

- **Solution:** Insted of ```z4``` any RV32I register can be used. eg. ```and s7, ra, a4```
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/58fa3863-0187-4d40-a517-9c603a26a282)

  
### 2nd Bug:
- Invalid Instruction was used or Invalid immediate vlaue is missing: ```andi s5, t1, s0```
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/0c27cbc8-6c9c-49c8-a625-d83227b00ed7)
  
- **Solution:** In solution, there are 2 ways to solve this error, first use `and` insted of `andi`, second give immediate value in operand.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/9ed2c341-9a29-4763-8be5-eebcf4fec83a)
