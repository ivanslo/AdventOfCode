from Solution import solution1, solution2

def parseFile( filename: str ) -> [int]:
	with open(filename, 'r') as f:
		lines = f.readlines()
	return [0]

TEST = True
REAL = False
## TESTS
if TEST:
	input1 = parseFile('input_test.txt')
	print(solution1(input1))
	print(solution2(input1))

## REAL
if REAL:
	input1 = parseFile('input.txt')
	print(solution1(input1))
	print(solution2(input1))
