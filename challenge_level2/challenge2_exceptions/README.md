# Exception Challenge
**Challenge:** Create a AAPG config file to generate a test with 10 illegal exceptions.
- **Solution:** By giving a non-zero value in ```exception-generation:```, we can generate any number of exceptions.
- In [my config](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/blob/main/challenge_level2/challenge2_exceptions/rv32i.yaml), I have set ```total_instructions``` to 10000 as well as ```ecause00 to ecause09``` to 5.
- By using this value in config we can get 10 exceptions.
  ![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/682814fa-b99f-4916-81c4-c9e6a38321bb)

### Generated Exceptions:
![image](https://github.com/vyomasystems-lab/riscv-ctb-challenge-meeeeet/assets/76646671/c0eb50a3-aef6-48ad-90a9-8e7c5f10d39d)
