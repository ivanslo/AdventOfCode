run: main
	cat input.txt | ./main

solutions: Solutions.hs 
	ghc Solutions.hs

main: solutions
	ghc main.hs 

test: solutions
	ghc tests.hs
	cat input_test.txt | ./tests

clear:
	rm -f *.o *.hi Solution main tests

