def group_counting( iterator ):
    stack = []
    groups = 0
    for c in iterator:
        # ignore the next element if there's a '!'
        if len(stack) > 0 and stack[-1] == '!':
            stack.pop()
            continue
        
        if c == '!':
            stack.append(c)

        if len(stack) > 0 and stack[-1] == '<':
            if c == '>':
                stack.pop()
            continue

        if c == '<':
            stack.append(c)
        if c == '{':
            stack.append(c)

        if c == '}':
            if stack[-1] == '{':
                stack.pop()
                groups = groups + 1
    
    if len(stack) != 0:
        print('!!something wrong happened')

    return groups

def solution_part1( iterator ):
    stack = []
    groups = 0
    for c in iterator:
        # ignore the next element if there's a '!'
        if len(stack) > 0 and stack[-1] == '!':
            stack.pop()
            continue
        
        if c == '!':
            stack.append(c)

        if len(stack) > 0 and stack[-1] == '<':
            if c == '>':
                stack.pop()
            continue

        if c == '<':
            stack.append(c)
        if c == '{':
            stack.append(c)

        if c == '}':
            if stack[-1] == '{':
                stack.pop()
                groups = groups + len(stack)+1
    
    if len(stack) != 0:
        print('!!something wrong happened')

    return groups


def solution_part1( iterator ):
    stack = []
    groups = 0
    for c in iterator:
        # ignore the next element if there's a '!'
        if len(stack) > 0 and stack[-1] == '!':
            stack.pop()
            continue
        
        if c == '!':
            stack.append(c)

        if len(stack) > 0 and stack[-1] == '<':
            if c == '>':
                stack.pop()
            continue

        if c == '<':
            stack.append(c)
        if c == '{':
            stack.append(c)

        if c == '}':
            if stack[-1] == '{':
                stack.pop()
                groups = groups + len(stack)+1
    
    if len(stack) != 0:
        print('!!something wrong happened')

    return groups

def solution_part2( iterator ):
    stack = []
    groups = 0
    garbage_count = 0
    for c in iterator:
        # ignore the next element if there's a '!'
        if len(stack) > 0 and stack[-1] == '!':
            stack.pop()
            continue
        
        if c == '!':
            stack.append(c)

        if len(stack) > 0 and stack[-1] == '<':
            if c == '>':
                stack.pop()
            else:
                garbage_count = garbage_count + 1
            continue

        if c == '<':
            stack.append(c)
        if c == '{':
            stack.append(c)

        if c == '}':
            if stack[-1] == '{':
                stack.pop()
                groups = groups + len(stack)+1
    
    if len(stack) != 0:
        print('!!something wrong happened')

    return garbage_count
def stream_file( filename ):
    with open(filename, 'r') as f:
        f.seek(0)
        while True:
            char = f.read(1)
            if char:
                yield char
            else:
                break


if __name__ == '__main__':
    print(" -- tests -- ")
    
    test1 = '{}' # => 1
    test2 = '{{{}}}' # =>, 3 groups.
    test3 = '{{},{}}' #=>, also 3 groups.
    test4 = '{{{},{},{{}}}}' # =>, 6 groups.
    test5 = '{<{},{},{{}}>}' # =>, 1 group
    test6 = '{<a>,<a>,<a>,<a>}' # =>, 1 group.
    test7 = '{{<a>},{<a>},{<a>},{<a>}}'  #=> 5 groups.
    test8 = '{{<!>},{<!>},{<!>},{<a>}}' # =>, 2

    test_r1 = '{}' #, score of 1.
    test_r2 = '{{{}}}' #, score of 1 + 2 + 3 = 6.
    test_r3 = '{{},{}}' #, score of 1 + 2 + 2 = 5.
    test_r4 = '{{{},{},{{}}}}' #, score of 1 + 2 + 3 + 3 + 3 + 4 = 16.
    test_r5 = '{<a>,<a>,<a>,<a>}' #, score of 1.
    test_r6 = '{{<ab>},{<ab>},{<ab>},{<ab>}}' #, score of 1 + 2 + 2 + 2 + 2 = 9.
    test_r7 = '{{<!!>},{<!!>},{<!!>},{<!!>}}' #, score of 1 + 2 + 2 + 2 + 2 = 9.
    test_r8 = '{{<a!>},{<a!>},{<a!>},{<ab>}}' #, score of 1 + 2 = 3
    
    #input2 = stream_file('input2.txt')
    #for c in input2: 
    #   ...


    print("test1: %s %d "%(test1, group_counting( test1 )))
    print("test2: %s %d "%(test2, group_counting( test2 )))
    print("test3: %s %d "%(test3, group_counting( test3 )))
    print("test4: %s %d "%(test4, group_counting( test4 )))
    print("test5: %s %d "%(test5, group_counting( test5 )))
    print("test6: %s %d "%(test6, group_counting( test6 )))
    print("test7: %s %d "%(test7, group_counting( test7 )))
    print("test8: %s %d "%(test8, group_counting( test8 )))

    print("test_r1: %s %d "%(test_r1, solution_part1( test_r1 )))
    print("test_r2: %s %d "%(test_r2, solution_part1( test_r2 )))
    print("test_r3: %s %d "%(test_r3, solution_part1( test_r3 )))
    print("test_r4: %s %d "%(test_r4, solution_part1( test_r4 )))
    print("test_r5: %s %d "%(test_r5, solution_part1( test_r5 )))
    print("test_r6: %s %d "%(test_r6, solution_part1( test_r6 )))
    print("test_r7: %s %d "%(test_r7, solution_part1( test_r7 )))
    print("test_r8: %s %d "%(test_r8, solution_part1( test_r8 )))
    
    print(' -- real -- ')
    real = stream_file('input.txt')
    print("test_real: %d "%( solution_part1( real ) ))


    print(' -- part 2 --')

    test_p2_1 = '<>' #, 0 characters.
    test_p2_2 = '<random characters>' #, 17 characters.
    test_p2_3 = '<<<<>' #, 3 characters.
    test_p2_4 = '<{!>}>' #, 2 characters.
    test_p2_5 = '<!!>' #, 0 characters.
    test_p2_6 = '<!!!>>' #, 0 characters.
    test_p2_7 = '<{o"i!a,<{i<a>' #, 10 characters.
    print("test1: %s %d "%(test_p2_1, solution_part2( test_p2_1 )))
    print("test2: %s %d "%(test_p2_2, solution_part2( test_p2_2 )))
    print("test3: %s %d "%(test_p2_3, solution_part2( test_p2_3 )))
    print("test4: %s %d "%(test_p2_4, solution_part2( test_p2_4 )))
    print("test5: %s %d "%(test_p2_5, solution_part2( test_p2_5 )))
    print("test6: %s %d "%(test_p2_6, solution_part2( test_p2_6 )))
    print("test7: %s %d "%(test_p2_7, solution_part2( test_p2_7 )))
    print(' -- real -- ')
    real = stream_file('input.txt')
    print("test_real: %d "%( solution_part2( real ) ))
