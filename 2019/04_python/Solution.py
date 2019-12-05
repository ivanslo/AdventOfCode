def splitFactors( nr: int ) -> [int]:
	pp = []

	for i in range(6):
		pp.append(nr%10)
		nr = int(nr /10)
	pp.reverse()
	return pp


def isValidSol2( fac: [int]) -> bool:
	# check two equals no more
	valid = False
	seen = [0]*10
	for i in fac:
		seen[i] += 1
	
	for s in seen:
		if s == 2:
			valid = True
	return valid


def isValid( fac: [int]) -> bool:
	# check ascending
	# check two equals are together
	ascending = True
	twoEquals = False
	for i in range(5):
		if fac[i] > fac[i+1]:
			ascending = False
		if fac[i] == fac[i+1]:
			twoEquals = True
	return ascending and twoEquals
	
def checkNr( nr: int) -> bool:
	factors = splitFactors(nr)
	if isValid(factors):
		return True
	return False

def checkNr2( nr: int) -> bool:
	factors = splitFactors(nr)
	if isValid(factors) and isValidSol2(factors):
		return True
	return False


# --- entry points

def solution1( fr: int, to: int) -> int:
	totalValid = 0
	for n in range(fr, to+1):
		if checkNr(n):
			totalValid += 1
	return totalValid

def solution2( fr: int, to: int) -> int:
	totalValid = 0
	for n in range(fr, to+1):
		if checkNr2(n):
			totalValid += 1
	return totalValid
