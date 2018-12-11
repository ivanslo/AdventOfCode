run: main
	./main

solutions: Solutions.hs 
	ghc Solutions.hs

main: solutions
	ghc main.hs 

test: solutions
	ghc tests.hs
	./tests

clear:
	rm -f *.o *.hi Solution main tests

