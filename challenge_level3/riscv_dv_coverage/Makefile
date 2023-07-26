all: setup run coverage
setup: 
	export PYTHONPATH=/tools/riscv-dv/pygen:$PYTHONPATH
	export PATH=/tools/spike_hyp_latest/bin:$PATH
run: 
	@echo 'Run......................'
	run	--target rv32i --test riscv_arithmetic_basic_test --testlist testlist.yaml --simulator pyflow

# in coverage section the folder name of 'out_' may be different, use same name as generated in 'run' command.
coverage:
	@echo 'CoverageReport................'
	cov --dir out_2023-07-26/spike_sim/ --simulator=pyflow
	cat cov_out_2023-07-26/CoverageReport.txt
