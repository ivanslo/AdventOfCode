
def processInput( lines ):
    registers = {}
    
    for line in lines:
        tokens = line.split(' ')

        reg = tokens[0]
        ope = tokens[1]
        val = tokens[2]
        cond_reg = tokens[4]
        cond_con = tokens[5]
        cond_val = tokens[6]

        if not reg in registers:
            registers[reg] = 0
        if not cond_reg in registers:
            registers[cond_reg] = 0

        if condition_ok(registers, cond_reg, cond_con, cond_val):
            apply_operation(registers, reg, ope, val)

    return registers

def processInput2( lines ):
    registers = {}
    
    biggest_value = 0 # part 2
    for line in lines:
        tokens = line.split(' ')

        reg = tokens[0]
        ope = tokens[1]
        val = tokens[2]
        cond_reg = tokens[4]
        cond_con = tokens[5]
        cond_val = tokens[6]

        if not reg in registers:
            registers[reg] = 0
        if not cond_reg in registers:
            registers[cond_reg] = 0

        if condition_ok(registers, cond_reg, cond_con, cond_val):
            apply_operation(registers, reg, ope, val)

        if registers[reg] > biggest_value:
            biggest_value = registers[reg]

    return biggest_value

def condition_ok( regs, reg, cond, val):
    val = int(val)
    expression = str(regs[reg]) + cond + str(val)
    return eval(expression)

def apply_operation( regs, reg, op, val):
    modifier = 1
    if op == 'dec':
        modifier = -1
    regs[reg] = regs[reg] + int(val) * modifier

import sys

def getBiggest( regs ):
    biggest = ''
    for i,key in enumerate(regs.keys()):
        if i == 0:
            biggest = key
            continue

        if regs[key] > regs[biggest] :
            biggest = key
    return biggest

if __name__ == '__main__':
    example1 = [
        'b inc 5 if a > 1',
        'a inc 1 if b < 5',
        'c dec -10 if a >= 1',
        'c inc -20 if c == 10'
    ]

    instructions = processInput( example1 )
    
    great = getBiggest(instructions)
    print("biggest register are %s => %d" % (great, instructions[great]))
    f = open('input.txt', 'r')
    realInput = f.readlines()
    realInput = [r.rstrip() for r in realInput]
    f.close()

    instructions = processInput( realInput )
    great = getBiggest(instructions)
    print("biggest register are %s => %d" % (great, instructions[great]))


    print(' part2 ')
    biggest_record = processInput2( example1 )
    print("biggest record is %d" % (biggest_record))
    biggest_record = processInput2( realInput )
    print("biggest record is %d" % (biggest_record))
