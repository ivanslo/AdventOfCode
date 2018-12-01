run: main
	cat input.txt | ./main

solutions: Solutions.hs 
	stack ghc Solutions.hs

main: solutions
	stack ghc main.hs 

test: solutions
	stack ghc tests.hs
	./tests

clear:
	rm -f *.o *.hi Solution main tests

