from Solution import solution1, solution2

def parseFile( filename: str ) -> [(int,int)]:
	limitX = 0
	limitY = 0
	entries = []
	with open(filename, 'r') as f:
		lines = f.readlines()
		for l in lines:
			l = l.strip()
			limitX = len(l)
			for x,v in enumerate(l):
				if v == '#':
					entries.append((x,limitY))
			limitY += 1
			# print(l)
	
	# print(entries, limitX, limitY-1)
	return entries, limitX, limitY-1

TEST = True
REAL = False
## TESTS
if TEST:
	input1, limX, limY  = parseFile('input_test.txt')
	maxHits, pos = solution1(input1, limX, limY)
	print(maxHits, pos)
	
	solution2(input1, limX, limY, pos)
	# print(solution2(input1))

## REAL
if REAL:
	input1, limX, limY = parseFile('input.txt')
	print(solution1(input1, limX, limY))
	# print(solution2(input1))
