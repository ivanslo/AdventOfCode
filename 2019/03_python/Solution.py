

class Movement:
	direction = ''
	steps = 0

	def __repr__(self):
		return ""+ self.direction + " " + str(self.steps) 

	def __str__(self):
		return ""+ self.direction + " " + self.steps

class Pos:
	x = 0
	y = 0
	d = 0 # manhattan distance
	s = 0 # steps it took to get there
	def __init__(self, x, y):
		self.x = x
		self.y = y
		self.d = abs(x)+abs(y)
		self.s = 0

	def __repr__(self):
		return "("+ str(self.x)+","+ str(self.y)+")["+str(self.d)+"]["+str(self.s)+"]"

	def __lt__(self, other):
		return self.d < other.d
	
	def __eq__(self, other):
		return self.x == other.x and self.y == other.y


def getPositionsInBetween(a : Pos, b: Pos)-> [Pos] :
	positions = []

	d = 1
	if a.x == b.x:
		# over vertical
		if a.y > b.y:
			d = -1
		for i in range(a.y+d, b.y+d, d):
			positions.append(Pos(a.x, i))
	if a.y == b.y:
		# over horizontal
		if a.x > b.x:
			d = -1
		for i in range(a.x+d, b.x+d, d):
			positions.append(Pos(i, a.y))

	return positions


def getPositions(wire: [Movement])-> [Pos]:
	visitedPositions = []
	currentPos = Pos(0,0)
	for wp in wire:
		newPos = Pos(currentPos.x, currentPos.y)
		if wp.direction == 'U':
			newPos.y += wp.steps
		if wp.direction == 'D':
			newPos.y -= wp.steps
		if wp.direction == 'R':
			newPos.x += wp.steps
		if wp.direction == 'L':
			newPos.x -= wp.steps
		visitedPositions += getPositionsInBetween(currentPos, newPos)
		currentPos = newPos
	
	
	for i,vp in enumerate(visitedPositions):
		vp.s = i+1

	return visitedPositions


def getCommonPositions(l1, l2):
	common = []
	for p1 in l1:
		for p2 in l2:
			if p1.x == p2.x and p1.y == p2.y:
				common.append(p1)
	return common
	

def dist_compare(a, b):
	return (a.x+a.y) - (b.x+b.y)



def makeHashOfDistances( pos: [Pos]) -> ({int: [Pos]}, int):
	table = {}

	maxDist = 0

	for p in pos:
		inD = table.get(p.d, [])
		inD.append(p)
		table[p.d] = inD
		maxDist = max(p.d, maxDist)
		 
	return table, maxDist
		

def solution1( wires: [[Movement]]) -> int:
	wire1List = getPositions(wires[0])
	wire2List = getPositions(wires[1])

	w1hash, maxD1 = makeHashOfDistances(wire1List)
	w2hash, maxD2 = makeHashOfDistances(wire2List)
	

	for d in range(max(maxD1, maxD2)):
		list1 = w1hash.get(d, [])
		list2 = w2hash.get(d, [])
		for l1 in list1:
			if l1 in list2:
				return d

	return -1

def sumSteps( pospair: (Pos, Pos)) -> int:
	return pospair[0].s + pospair[1].s

def solution2( wires: [[Movement]]) -> int:
	wire1List = getPositions(wires[0])
	wire2List = getPositions(wires[1])

	w1hash, maxD1 = makeHashOfDistances(wire1List)
	w2hash, maxD2 = makeHashOfDistances(wire2List)
	
	pairs = []
	for d in range(max(maxD1, maxD2)):
		list1 = w1hash.get(d, [])
		list2 = w2hash.get(d, [])
		for l1 in list1:
			for l2 in list2:
				if l1 == l2:
					pairs.append((l1,l2))
	pairsS = sorted(pairs, key=sumSteps)

	# print(pairsS)
				
	return pairsS[0][0].s + pairsS[0][1].s



