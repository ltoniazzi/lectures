
FILE_NAME ?= trivial_reduce


run:
	nvcc -o $(FILE_NAME) $(FILE_NAME).cu && ./$(FILE_NAME) 

run_trivial:
	$(MAKE) run FILE_NAME=trivial_reduce

run_thread:
	$(MAKE) run FILE_NAME=thread_reduce

run_block:
	$(MAKE) run FILE_NAME=block_reduce

run_all:
	$(MAKE) run_trivial
	$(MAKE) run_thread
	$(MAKE) run_block
