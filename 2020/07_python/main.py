from Solution import solution1, solution2
import sys

def allLines():
	lines = []
	for line in sys.stdin:
		lines.append(line.strip())

	return lines

lines = allLines()

print(solution1(lines))
print(solution2(lines))
