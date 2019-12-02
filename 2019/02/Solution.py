

	
def processCode( codes: [int]) -> int:
	i = 0
	while codes[i] != 99:
		i1 = codes[i+1]
		i2 = codes[i+2]
		ir = codes[i+3]
	
		r = 0
		if codes[i] == 1:
			r = codes[i1] + codes[i2]
		if codes[i] == 2:
			r  = codes[i1] * codes[i2]
		codes[ir] = r
		i+=4

	return codes[0]


def modifyInputAndSolve(codes: [int], noun: int, verb: int)->int:
	codes[1] = noun
	codes[2] = verb
	return processCode(codes)

def solution1( codes: [int]) -> int:
	return modifyInputAndSolve( codes, 0, 3 )

def solution2( codes: [int]) -> int:
	noun = 0
	verb = 0
	for i in range(99):
		for j in range(99):
			codes_copy = codes[:]
			if modifyInputAndSolve(codes_copy, i, j) == 19690720:
				noun = i
				verb = j
				break;

	return noun * 100 + verb



