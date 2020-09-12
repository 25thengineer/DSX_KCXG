# -*- Mode: makefile -*-
# Copyright (c) 1999 Matthew Wall, all rights reserved
# -----------------------------------------------------------------------------
#   To make all of the examples, do 'make'.  You can compile any one of
# the examples by typing 'make exN' where N is the number of the example you
# want to compile.  See the README for a description of what each example does.
# -----------------------------------------------------------------------------

include ../makevars

# Set these paths to the location of the GA library and headers.
#GA_INC_DIR= /usr/local/include
#GA_LIB_DIR= /usr/local/lib
GA_INC_DIR= ..
GA_LIB_DIR= ../ga

INC_DIRS= -I$(GA_INC_DIR)
LIB_DIRS= -L$(GA_LIB_DIR)

EXS=  randtest \
 ex1    ex2    ex3    ex4    ex5    ex6    ex7    ex8    ex9 \
 ex10   ex11   ex12   ex13   ex14   ex15   ex16   ex17   ex18 \
 ex19   ex20   ex21   ex22   ex23   ex24   ex25   ex26   ex27

all: $(EXS)

# Use this for non-gnu make
#$(EXS): $$@.o
#	$(CXX) $@.o -o $@ $(LIB_DIRS) -lga -lm

# Use this for gnu make
$(EXS): %: %.o
	$(CXX) $@.o -o $@ $(LIB_DIRS) -lga -lm

clean:
	$(RM) $(EXS) 
	$(RM) *.o *~ *.bak *.pixie core
	$(RM) test_results.txt *.dat
	$(RM) *.out *.exe vc* *.pdb

test: $(EXS)
	$(RM) test_results.txt
	@echo "running tests.  this could take up to 1/2 hour, "
	@echo "depending on the speed of your computer."
	@echo ""
	@echo "randtest..."; randtest seed 555 > test_results.txt
	@echo "ex1... "; ex1 seed 555 >> test_results.txt
	@echo "ex2... "; ex2 seed 555 >> test_results.txt
	@echo "ex3... "; ex3 seed 555 >> test_results.txt
	@echo "ex4... "; ex4 seed 555 >> test_results.txt
	@echo "ex5... "; ex5 seed 555 >> test_results.txt
	@echo "ex6... "; ex6 seed 555 >> test_results.txt
	@echo "ex7... "; ex7 seed 555 >> test_results.txt
	@echo "ex8... "; ex8 seed 555 >> test_results.txt
	@echo "ex9... "; ex9 seed 555 >> test_results.txt
	@echo "ex10..."; ex10 seed 555 >> test_results.txt
	@echo "ex11..."; ex11 seed 555 >> test_results.txt
	@echo "ex12..."; ex12 seed 555 >> test_results.txt
	@echo "ex13..."; ex13 seed 555 >> test_results.txt
	@echo "ex14..."; ex14 seed 555 >> test_results.txt
	@echo "ex15..."; ex15 seed 555 >> test_results.txt
	@echo "ex16..."; ex16 seed 555 >> test_results.txt
	@echo "ex17..."; ex17 seed 555 >> test_results.txt
	@echo "ex18..."; ex18 seed 555 >> test_results.txt
	@echo "ex19..."; ex19 seed 555 >> test_results.txt
	@echo "ex20..."; ex20 seed 555 >> test_results.txt
	@echo "ex21..."; ex21 seed 555 >> test_results.txt
	@echo "ex22..."; ex22 seed 555 >> test_results.txt
	@echo "ex23..."; ex23 seed 555 >> test_results.txt
	@echo "ex24..."; ex24 seed 555 >> test_results.txt
	@echo "ex25..."; ex25 seed 555 >> test_results.txt
	@echo "ex26..."; ex26 seed 555 >> test_results.txt
	@echo "ex27..."; ex27 seed 555 >> test_results.txt
