""" --- Day 3: Spiral Memory ---

You come across an experimental new kind of memory stored on an infinite
two-dimensional grid.

Each square on the grid is allocated in a spiral pattern starting at a
location marked 1 and then counting up while spiraling outward. For
example, the first few squares are allocated like this:

17  16  15  14  13 
18   5   4   3  12 
19   6   1   2  11
20   7   8   9  10 
21  22  23---> ...

While this is very space-efficient (no squares are skipped), requested
data must be carried back to square 1 (the location of the only access
port for this memory system) by programs that can only move up, down,
left, or right. They always take the shortest path: the Manhattan Distance
between the location of the data and square 1.

For example:

    Data from square 1 is carried 0 steps, since it's at the access port.
    Data from square 12 is carried 3 steps, such as: down, left, left.
    Data from square 23 is carried only 2 steps: up twice.  Data from
    square 1024 must be carried 31 steps.

How many steps are required to carry the data from the square identified
in your puzzle input all the way to the access port?

Your puzzle input is 325489.

-- Part Two ---

As a stress test on the system, the programs here clear the grid and then
store the value 1 in square 1. Then, in the same allocation order as shown
above, they store the sum of the values in all adjacent squares, including
diagonals.

So, the first few squares' values are chosen as follows:

    Square 1 starts with the value 1.  Square 2 has only one adjacent
    filled square (with value 1), so it also stores 1.  Square 3 has both
    of the above squares as neighbors and stores the sum of their values,
    2.  Square 4 has all three of the aforementioned squares as neighbors
    and stores the sum of their values, 4.  Square 5 only has the first
    and fourth squares as neighbors, so it gets the value 5.

Once a square is written, its value does not change. Therefore, the first
few squares would receive the following values:

147  142  133  122   59
304    5    4    2   57
330   10    1    1   54
351   11   23   25   26
362  747  806--->   ...

What is the first value written that is larger than your puzzle input?

Your puzzle input is still 325489.
"""
import math
import sys
# PART 2

UP = 1
LE = 2
DO = 3
RI = 4
def solution2( val ):
    table = []
    table_size =15
    for i in range(table_size):
        table.append( [0]*table_size)

    x , y = int(table_size /2), int(table_size/2)
    table[y][x] = 1
    x = x + 1
    table[y][x] = 1


    direction = UP
    while True:
        x,y,direction = get_next_position(table, x, y, direction)
        value = get_value( table, x, y)
        table[y][x] = value

        if value > val:
            print_table(table)
            return value
    

def get_next_position(table, x, y, direction):
    if direction == UP:
        if table[y][x-1] == 0:  #look left
            direction = LE
            x = x-1
        else:
            y = y -1
    elif direction == LE:
        if table[y+1][x] == 0: #look down
            direction = DO
            y = y+1
        else:
            x = x-1
    elif direction == DO:
        if table[y][x+1] == 0: #look right
            direction = RI
            x = x+1
        else:
            y = y +1
    elif direction == RI:
        if table[y-1][x] == 0: #look up
            direction = UP
            y = y-1
        else:
            x = x+1
    return x,y,direction


def get_value( t, x, y ):
    
    total = t[y+1][x] + t[y-1][x] + \
            t[y][x+1] + t[y][x-1] +\
            t[y+1][x+1] + t[y-1][x+1] +\
            t[y+1][x-1] + t[y-1][x-1]
    return total

def print_table( t ):
    for row in t:
        for v in row:
            sys.stdout.write("%8d" % v)
        print()

# PART 1
def solution( sq ):
    layer, values = get_marks(sq)
    m = sq
    for v in values:
        if abs(v - sq) < m:
            m = abs(v-sq)
    dist = math.floor(layer / 2)
    return m + dist


def get_marks(up_to):
    circle = math.ceil(math.sqrt(up_to))
    if circle % 2 == 0:
        circle = circle + 1
    
    elem_there = (circle - 1) * 4
    gap = circle -1 
    start = circle ** 2 - gap / 2
    core_values = [int(start-x*gap) for x in range(4)]
    return circle, core_values


if __name__ == '__main__':
    print("-- tests --")
    print("input: %d => result: %s" % (1, solution(1)))
    print("input: %d => result: %s" % (7, solution(7)))
    print("input: %d => result: %s" % (12, solution(12)))
    print("input: %d => result: %s" % (23, solution(23)))
    print("input: %d => result: %s" % (35, solution(35)))
    print("input: %d => result: %s" % (64, solution(64)))
    print("input: %d => result: %s" % (109, solution(109)))
    print("input: %d => result: %s" % (1024, solution(1024)))
    print("-- solution --")
    print("input: %d => result: %s" % (325489, solution(325489)))
    print("-- solution 2--")
    print("input: %d => result: %s" % (32, solution2(32)))
    print("input: %d => result: %s" % (1032, solution2(1032)))
    print("input: %d => result: %s" % (3332, solution2(3332)))
    print("input: %d => result: %s" % (325489, solution2(325489)))
