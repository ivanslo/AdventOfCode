def solution( blocks ):
    """ 
    PART 1 
    """
    saw = []
    while True:
        bl = [str(x) for x in blocks]
        pattern = "-".join(bl)
        if saw.__contains__(pattern):
            break
        saw.append(pattern)
        
        max_idx = blocks.index(max(blocks))
        blocks = redistribute_from(blocks, max_idx)

    return len(saw)

def solution_part2(blocks):
    """ PART 2 """
    saw = {}
    last_saw = 0
    i = 0
    while True:
        i = i + 1
        bl = [str(x) for x in blocks]
        pattern = "-".join(bl)
        if saw.has_key(pattern):
            last_saw = saw[pattern]
            break
        saw[pattern] = i
        
        max_idx = blocks.index(max(blocks))
        blocks = redistribute_from(blocks, max_idx)
    
    return i - last_saw

def redistribute_from( blocks, index ):
    n_blocks = len(blocks)

    redist = blocks[index]
    each = redist / n_blocks
    rest = redist  % n_blocks

    blocks = [(x+each) for x in blocks]
    blocks[index] = blocks[index] - redist
    i = index 
    while rest > 0:
        i = (i+1) % n_blocks
        blocks[i] = blocks[i] + 1
        rest = rest - 1

    return blocks


if __name__ == '__main__':
    print("-- tests --")
    print("-- part 1 --")
    input1= [0, 2, 7, 0]
    print("input: %s => result: %s" % (input1, solution(input1)))

    f = open('input.txt', 'r')
    line = f.readlines()[0].rstrip()
    f.close()
    input_real = line.split('\t')
    input_real = [int(x) for x in input_real]

    print("input: %s => result: %s" % (input_real, solution(input_real)))

    print("-- tests --")
    print("-- part 2 --")
    input2= [0, 2, 7, 0]
    print("input: %s => result: %s" % (input2, solution_part2(input2)))

    f = open('input.txt', 'r')
    line = f.readlines()[0].rstrip()
    f.close()
    input_real = line.split('\t')
    input_real = [int(x) for x in input_real]

    print("input: %s => result: %s" % (input_real, solution_part2(input_real)))
