def buildTable( orbits: [[str]]) -> {}:
	table = {}
	for orbit in orbits:
		table[orbit[1]] = orbit[0]
	return table


def countDirectAndIndirects( t: {}, o: str) -> int:
	return len(getDirectAndIndirects(t,o))

def getDirectAndIndirects( t: {}, o:str) -> [str]:
	orbits = []
	key = o
	while t.get(key):
		orbits.append(t[key])
		key = t[key]
	return orbits


# --------------------------------------------------------

def solution1( orbits: [[str]]) -> int:
	table = buildTable(orbits)
	
	totalCount = 0
	for key in table:
		totalCount += countDirectAndIndirects(table, key)

	return totalCount

# --------------------------------------------------------

def solution2( orbits: [[str]]) -> int:
	table = buildTable(orbits)
	destiniesForSam = getDirectAndIndirects(table, 'SAN')
	dest = 'YOU'

	stepsYou = 0
	while True:
		dest = table[dest]
		try:
			stepsToSan = destiniesForSam.index(dest)  # -- what takes to SAN to get to the common place
			stepsYou += stepsToSan
		except ValueError:
			stepsYou +=1
			pass
		else:
			break

	return stepsYou
