# Challenge Level-2
## Table of Contents

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

