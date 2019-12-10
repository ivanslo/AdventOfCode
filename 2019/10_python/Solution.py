def getMcm(a: int, b: int) -> int:
	if b == 0:
		return a
	return getMcm(b, a%b)

def findStep( val: (int, int) ) -> (int,int):
	mcm = getMcm(abs(val[0]), abs(val[1]))
	if mcm == 0:
		print("WHAT")

	return (int(val[0] / mcm), int(val[1]/mcm))


def solution1( points: [(int, int)], limX: int, limY: int) -> int:
	# print("all Points", points)
	# print("Limits: ",limX, limY)
	
	allSteroids = set(points)
	# step = findStep((-8, 4))
	
	reach = {}
	maxBase = (0,0)
	maxHits = 0
	for i, base in enumerate(points):
		# print("B", base)
		reach[base] = 0
		for dest in points:
			dest_normalized = (dest[0] - base[0], dest[1]-base[1])
			if dest_normalized[0] == 0 and dest_normalized[1] == 0:
				continue
			step = findStep(dest_normalized)
			# print(" D", dest, "S: ", step, " (base)", base)
			
			s = (base[0]+step[0], base[1]+step[1])
			found = False
			while s != dest:
				if s in allSteroids:
					found = True
				s = (s[0] + step[0], s[1] + step[1])

			if not found:
				reach[base] += 1
		if reach[base] > maxHits:
			maxHits = reach[base]
			maxBase = base
		
	# print(maxHits)
	# print(maxBase)

	return maxHits, maxBase

def solution2( things: [int]) -> int:
	return 0
