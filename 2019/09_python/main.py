
from Solution import solution1, solution2



def parseFile( filename: str ) -> [int]:
	numbers = []
	with open( filename, 'r') as f:
		line = f.readline()
		numbers = line.split(',')
	numbers = [ int(n.strip()) for n in numbers]
	return numbers
	
## TEST

# input_test = parseFile('input_test.txt')
# input_test = [1002,4,3,4,33]
# print(solution1(input_test))
# print(input_test)
# print(solution1([2,3,0,3,99]))
# print(solution1([109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]))
# print(solution1([1102,34915192,34915192,7,4,7,99,0]))
# print(solution1([104,1125899906842624,99]))
# print(solution1([2,4,4,5,99,0]))
# print(solution1([1,1,1,4,99,5,6,0,99]))

input1 = parseFile('input.txt')
solution1(input1[:])
# solution2(input1[:], 5)
#
# solution2([3,9,8,9,10,9,4,9,99,-1,8], 8)
# solution2([3,9,8,9,10,9,4,9,99,-1,8], 9)
# solution2([3,9,7,9,10,9,4,9,99,-1,8], 7)
# solution2([3,9,7,9,10,9,4,9,99,-1,8], 8)
# solution2([3,3,1108,-1,8,3,4,3,99], 8)
# solution2([3,3,1108,-1,8,3,4,3,99], 7)
# solution2([3,3,1107,-1,8,3,4,3,99], 5)
# solution2([3,3,1107,-1,8,3,4,3,99], 8)
