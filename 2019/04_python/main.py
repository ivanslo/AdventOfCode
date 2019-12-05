from Solution import solution1, solution2, checkNr, checkNr2

def parseFile( filename: str ) -> [int]:
	with open(filename, 'r') as f:
		lines = f.readlines()
	return [0]

TEST = True
REAL = False
## TESTS
if TEST:
	print(checkNr(111111))
	print(checkNr(223450))
	print(checkNr(123789))
	print(checkNr2(112233))
	print(checkNr2(123444))
	print(checkNr2(111122))
if REAL:
	print(solution1(109165,576723))
	print(solution2(109165,576723))
