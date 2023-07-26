
# Output directory
DIR := out_
OUT_DIR := $(DIR)$(shell date +%Y-%m-%d)

# Coverage directory
COV_DIR := cov_$(OUT_DIR)

all: setup run coverage
setup: 
	export PYTHONPATH=/tools/riscv-dv/pygen:$PYTHONPATH
	export PATH=/tools/spike_hyp_latest/bin:$PATH
run: 
	@echo 'Run......................'
	run	--target rv32i --test riscv_arithmetic_basic_test --testlist testlist.yaml --simulator pyflow

coverage:
	@echo 'CoverageReport................'
	cov --dir $(OUT_DIR)/spike_sim/ --simulator=pyflow
	cat $(COV_DIR)/CoverageReport.txt
