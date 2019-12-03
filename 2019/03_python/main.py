
from Solution import solution1, solution2, Movement



def parsePosition( string: str) -> [Movement]:
	movs = [m.strip() for m in string.split(",")]
	movements = []
	for mov in movs:
		m = Movement()
		m.direction = mov[0]
		m.steps = int(mov[1:])
		movements.append(m)
	return movements

def parseFile( filename: str ) -> [[Movement]]:
	positions = []
	with open( filename, 'r') as f:
		lines = f.readlines()
		for line in lines:
			positions.append(parsePosition(line))

	return positions
	
TEST = True
REAL = True
if TEST :
	""" TEST GIVEN #1 """
	test1= ["R75,D30,R83,U83,L12,D49,R71,U7,L72","U62,R66,U55,R34,D71,R55,D58,R83"]
	positions = []
	positions.append(parsePosition(test1[0]))
	positions.append(parsePosition(test1[1]))
	print(solution1(positions))
	print(solution2(positions))
	""" TEST GIVEN #2 """
	test2= ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51","U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]
	positions = []
	positions.append(parsePosition(test2[0]))
	positions.append(parsePosition(test2[1]))
	print(solution1(positions))
	print(solution2(positions))
if REAL:
	testcase1 = parseFile("input.txt")
	print(solution1(testcase1))
	print(solution2(testcase1))
