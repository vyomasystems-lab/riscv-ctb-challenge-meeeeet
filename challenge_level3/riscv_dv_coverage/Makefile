all: setup run coverage
setup: 
	export PYTHONPATH=/tools/riscv-dv/pygen:$PYTHONPATH
	export PATH=/tools/spike_hyp_latest/bin:$PATH
run: 
	@echo 'Run......................'
	run	--target rv32i --test riscv_arithmetic_basic_test --testlist testlist.yaml --simulator pyflow
	# run	--target rv32i --test riscv_single_asm_test --testlist testlist.yaml --simulator pyflow
coverage:
	@echo 'CoverageReport................'
	cov --dir out_2023-07-26/spike_sim/ --simulator=pyflow
	cat cov_out_2023-07-26/CoverageReport.txt
	