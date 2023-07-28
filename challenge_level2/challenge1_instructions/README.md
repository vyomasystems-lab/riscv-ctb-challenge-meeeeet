## Challenge Level2 - Instructions
### Bug:
- In this config file AAPG, the value of ```rel_rv64m``` is set on 10, that means
  some of the generated instructions will be RV64M type.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/221673aa-e577-4bde-bfb8-b4059a3b82ac)
- It is giving error because in make file for simulation rv32i architecture is used. That's why if AAPG will generate RV64M type instrucions then complier or simulator will not be able to complile or simulate those instructions.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/bd6960f5-3c48-4d94-b6e3-890b5a042b5a)

### Corrections:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/acba5dc8-f6d1-4bba-a1c2-8a18ec601e7b)
