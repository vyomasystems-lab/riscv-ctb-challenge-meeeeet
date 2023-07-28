# See LICENSE fandi license details.

#*****************************************************************************
# add.S
#-----------------------------------------------------------------------------
#
# Test add instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32M
RVTEST_CODE_BEGIN

  .align 2
  .option nandivc
  li TESTNUM, 2

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

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
