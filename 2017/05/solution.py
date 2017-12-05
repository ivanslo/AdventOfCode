def solution( machine ):
    #print(machine)
    limit = len(machine)
    pos = 0
    steps = 0
    while pos >= 0 and pos < limit:
        steps = steps + 1
        pos = execute_instruction_p2(machine, pos)
    return steps

def execute_instruction_p1(machine, pos):
    increment = machine[pos]
    machine[pos] = machine[pos] + 1
    return pos + increment

# part 2
def execute_instruction_p2(machine, pos):
    increment = machine[pos]
    inc = 1
    if increment >= 3:
        inc = -1

    machine[pos] = machine[pos] + inc
    return pos + increment

if __name__ == '__main__':
    print("-- tests --")
    input1= [0, 3, 0, 1, -3]
    print("input: %s => result: %s" % (input1, solution(input1)))

    f = open('input.txt', 'r')
    lines = f.readlines()
    lines = [l.rstrip() for l in lines]
    input_part1 = [int(x) for x in lines]
    f.close()

    print("-- part 1 --")
    print("input: %s => result: %s" % ("so big", solution(input_part1)))
