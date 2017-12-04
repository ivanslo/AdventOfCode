def isValidp2( password ):
    words = password.split(' ')
    cc = []
    for w in words:
        key = ''.join(sorted(w))
        if cc.__contains__(key):
            return False
        else:
            cc.append(key)
    return True


def isValid( password ):
    words = password.split(' ')
    cc = []
    for w in words:
        if cc.__contains__(w):
            return False
        else:
            cc.append(w)
    return True

if __name__ == '__main__':
    print("-- tests --")

    inputs= ["aa bb cc dd ee", "aa bb cc dd aa", "aa bb cc dd aaa"]

    for inp in inputs:
        print("input: %s => result: %s" % (inp, isValid(inp)))

    f = open('input.txt', 'r')
    lines = f.readlines()
    lines = [l.rstrip() for l in lines]
    f.close()

    print("-- part 1 --")
    i = 1

    valids_array = [x for x in lines if isValid(x)]
    valids = len(valids_array)

    #for inp in lines:
    #    valid = isValid(inp)
    #    #print("%3d | input: %s => result: %s" % (i, inp, valid))
    #    if valid:
    #        valids = valids + 1
    #    i = i + 1

    print("valids: %s => result %d" % ("input", valids))
    
    print("-- part 2 --")

    # anagrams
    valids_p2 = [x for x in lines if isValidp2(x)]
    print("valids: %s => result %d" % ("input", len(valids_p2)))
