
from Solution import solution1, solution2



def parseFile( filename: str ) -> [int]:
	numbers = []
	with open( filename, 'r') as f:
		line = f.readline()
		numbers = line.split(',')
	numbers = [ int(n.strip()) for n in numbers]
	return numbers
	
## TEST

# print(solution1([1,0,0,0,99]))
# print(solution1([2,3,0,3,99]))
# print(solution1([2,4,4,5,99,0]))
# print(solution1([1,1,1,4,99,5,6,0,99]))

input1 = parseFile('input.txt')
print(solution1(input1[:]))
print(solution2(input1[:]))
