## Challenge Level1 - Illegal

### Bug:
- In this exception handler, once exception caught it is going on infinite loop.
- Because after executing ```mtvec_handler```, the value of ```mepc``` is not getting incremented.
- **Solution:** By increamenting ```mepc``` by 8 location this bug can be solved.
### Corrected Handler:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/27c7e1a0-968a-486f-b4b7-540ac9a5d57b)
