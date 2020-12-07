from Solution import solution1, solution2
import sys

def expect(a, b):
	msg = "Expected {} and obtained {}".format(a,b)

	if a == b:
		print("[ OK  ]", msg)
	else:
		print("[Error]", msg)

def allLines():
	lines = []
	for line in sys.stdin:
		lines.append(line.strip())

	return lines


lines = allLines()

expect(4, solution1( lines ) )
expect(32, solution2( lines ))
