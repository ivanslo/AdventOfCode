

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

def generateBorder(w: int,h: int, initialX: int) -> [(int,int)]:
	print("limits", w, h)
	border = []
	for x in range(initialX, w):
		border.append((x,0))
	for y in range(1, h):
		border.append((w-1,y))
	for x in range(w-2, -1, -1):
		border.append((x, h-1))
	for y in range(h-2, -1, -1):
		border.append((0, y))
	for x in range(1, initialX):
		border.append((x,0))
	return border
	

def add( a: (int, int), b:(int, int))-> (int, int):
	return (a[0]+b[0], a[1]+b[1])

def sub( a: (int, int), b:(int, int))-> (int, int):
	return (a[0]-b[0], a[1]-b[1])
def whithinLimits(bullet_target, limX, limY):
	if bullet_target[0] < 0 or bullet_target[1] < 0 or bullet_target[0] >= limX or bullet_target[1] >= limY:
		return False
	return True

def solution2( points: [(int, int)], limX :int, limY: int, base:(int, int)) -> int:
	border = generateBorder(limX, limY, base[0])
	# print(border)

	allSteroids = set(points)


	i = 0;
	hitNumber = 0
	while len(allSteroids) > 0 and hitNumber < 10:
		pointTarget = sub(border[i], base)

		step = findStep(pointTarget)
		print("step", step)

		hit = False
		bullet_target = add(base, step)
		while not hit and whithinLimits(bullet_target, limX, limY):
			if bullet_target in allSteroids:
				hit = True
				hitNumber += 1
				allSteroids.remove(bullet_target)
				print("HIT "+ str(hitNumber) + ", in pos " + str(bullet_target))
				printItAll(allSteroids, base, limX, limY)
				input('..')
			else:
				bullet_target = add(bullet_target, step)

		i = (i+1) % len(border)

	return 0

def printItAll(present,base, w, h):
	for i in range(h):
		for j in range(w):
			if (j, i) in present:
				if (j,i) == base:
					print('#', end='')
				else:
					print('o', end='')
			else:
				print(' ', end='')
		print('')
