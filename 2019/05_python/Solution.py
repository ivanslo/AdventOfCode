	
def getOperators( codes: [int], pos: int) -> ( int, int, int):
	instruction = codes[pos]
	code = instruction % 100
	howTo = [0,0,0]
	instruction  = int(instruction / 100)
	howTo[0] = instruction % 10
	instruction  = int(instruction / 10)
	howTo[1] = instruction % 10
	instruction  = int(instruction / 10)
	howTo[2] = instruction % 10
	
	i1 = codes[pos+1]
	if howTo[0] == 0 :
		i1 = codes[codes[pos+1]]
	i2 = codes[pos+2]
	if howTo[1] == 0 :
		i2 = codes[codes[pos+2]]
	i3 = codes[pos+3]

	return (i1, i2, i3)


def processCode( codes: [int]) -> int:
	i = 0
	while codes[i] != 99 and i < len(codes):
		op = codes[i] % 100
		if op == 1:
			i1, i2, i3 = getOperators(codes, i)
			# print("sum ", i1, i2, codes[i3])
			codes[i3] = i1 + i2
			i+=4
		elif op == 2:
			# print("mul")
			i1, i2, i3 = getOperators(codes, i)
			codes[i3] = i1 * i2
			i+=4
		elif op == 3:
			# print("input")
			codes[codes[i+1]] = 1 ## INPUT
			i+=2
		elif op == 4:
			# print("output")
			print(codes[codes[i+1]]) ## OUTPUT
			i+=2
		else:
			# print(i, codes[i])
			pass

	return codes[0]

def processCode2( codes: [int], input_code: int) -> int:
	i = 0
	while codes[i] != 99 and i < len(codes):
		op = codes[i] % 100
		if op == 1:
			i1, i2, i3 = getOperators(codes, i)
			# print("sum ", i1, i2, codes[i3])
			codes[i3] = i1 + i2
			i+=4
		elif op == 2:
			# print("mul")
			i1, i2, i3 = getOperators(codes, i)
			codes[i3] = i1 * i2
			i+=4
		elif op == 3:
			# print("input")
			codes[codes[i+1]] = input_code## INPUT
			i+=2
		elif op == 4:
			# print("output", i, codes[i])
			#
			print(codes[codes[i+1]]) ## OUTPUT
			i+=2
		elif op == 5:
			i1, i2, i3 = getOperators(codes, i)
			if i1 != 0:
				i = i2
			else:
				i += 3
			pass
		elif op == 6:
			i1, i2, i3 = getOperators(codes, i)
			if i1 == 0:
				i = i2
			else:
				i += 3
			# i+=2
			pass
		elif op == 7:
			i1, i2, i3 = getOperators(codes, i)
			if i1 < i2:
				codes[i3] = 1
			else:
				codes[i3] = 0
			i+=4
			pass
		elif op == 8:
			i1, i2, i3 = getOperators(codes, i)
			if i1 == i2:
				codes[i3] = 1
			else:
				codes[i3] = 0
			i+=4
			pass
		else:
			print(i, codes[i])
			pass

	return codes[0]

def modifyInputAndSolve(codes: [int], noun: int, verb: int)->int:
	codes[1] = noun
	codes[2] = verb
	return processCode(codes)

def solution1( codes: [int]) -> int:
	return processCode(codes)
	# return modifyInputAndSolve( codes, 0, 3 )

def solution2( codes: [int], input_code: int) -> int:
	return processCode2(codes, input_code)



