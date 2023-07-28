## Loop Challenge

### Error:
- Code is going in infinte loop.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/6ee74f7a-aa46-4dce-adbb-27a120245510)

### Bug:
- In this code, loop must be execute 3 times but it is going in infinite loop.
- Because in instructions of loop register ```t5``` isn't decreasing to 0.
- **Correction:** While comparing ```t3``` and ```t4```, if its correct than it
  should goes to another loop named ```continue_loop``` in which ```t5``` will
  decreased by 1 and loop will continue unless and until ```t5``` becomes to 0.
### Corrected Code:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/0fd56fc6-dd56-457f-b161-33b9c80a5cbe)
