	
def getOperators( codes: [int], pos: int, relativeBase: int) -> ( int, int, int):
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
	if howTo[0] == 2 :
		i1 = codes[relativeBase + codes[pos+1]]

	i2 = codes[pos+2]
	if howTo[1] == 0 :
		i2 = codes[codes[pos+2]]
	if howTo[1] == 2 :
		i2 = codes[relativeBase + codes[pos+2]]


	i3 = codes[pos+3]
	if howTo[2] == 2 :
		i3 = relativeBase + i3

	return (i1, i2, i3)


def processCode2( codes: [int], input_code: int) -> int:
	i = 0
	relBase = 0
	while codes[i] != 99 and i < len(codes):
		op = codes[i] % 100
		if op == 1:
			i1, i2, i3 = getOperators(codes, i, relBase)
			codes[i3] = i1 + i2
			i+=4
		elif op == 2:
			i1, i2, i3 = getOperators(codes, i, relBase)
			codes[i3] = i1 * i2
			i+=4
		elif op == 3:
			print("input", i1, i, codes[i], codes[i1], relBase)
			codes[relBase+codes[i+1]] = input_code
			i+=2
		elif op == 4:
			i1, i2, i3 = getOperators(codes, i, relBase)
			print(i, i1) ## OUTPUT
			i+=2
		elif op == 5:
			i1, i2, i3 = getOperators(codes, i, relBase)
			if i1 != 0:
				i = i2
			else:
				i += 3
			pass
		elif op == 6:
			i1, i2, i3 = getOperators(codes, i, relBase)
			if i1 == 0:
				i = i2
			else:
				i += 3
			pass
		elif op == 7:
			i1, i2, i3 = getOperators(codes, i, relBase)
			if i1 < i2:
				codes[i3] = 1
			else:
				codes[i3] = 0
			i+=4
			pass
		elif op == 8:
			i1, i2, i3 = getOperators(codes, i, relBase)
			if i1 == i2:
				codes[i3] = 1
			else:
				codes[i3] = 0
			i+=4
			pass
		elif op == 9:
			i1, i2, i3 = getOperators(codes, i, relBase)
			relBase += i1
			i += 2
		else:
			pass

	return codes[0]

def solution1( codes: [int]) -> int:
	extraMem = [0]*100000
	return processCode2(codes+extraMem, 2)

def solution2( codes: [int], input_code: int) -> int:
	return processCode2(codes, input_code)



