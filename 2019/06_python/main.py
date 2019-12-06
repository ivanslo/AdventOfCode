from Solution import solution1, solution2

def parseFile( filename: str ) -> [[str]]:
	orbits = []
	with open(filename, 'r') as f:
		lines = f.readlines()
		for l in lines:
			elem = [n.strip() for n in l.split(')')]
			orbits.append(elem)
	
	return orbits

TEST = True
REAL = True
## TESTS
if TEST:
	input1 = parseFile('input_test.txt')
	print(solution1(input1[:]))
	print(solution2(input1[:]))

## REAL
if REAL:
	input1 = parseFile('input.txt')
	print(solution1(input1))
	print(solution2(input1))
