# See LICENSE for license details.

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
  .option norvc
  li TESTNUM, 2

# Preparation

  li a0,0x12345678
  li a1,0x12345678
  li a2,0x1f2ff3ff
  li a3,0x000ff000
  li a4,0x0f0f0f00
  li a5,0xbfc0d0fe
  li a6,0x00abcdef
  li a7,0x11111111

# Test
  or x20, a0, a1       # Expected output: 0x0000ffff
  or x21, a2, a3
  or x22, a4, a5
  or x23, a6, a7

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
