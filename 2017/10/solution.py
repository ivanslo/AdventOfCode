"""
schema
"""
def process( elements, key ):
    idx = 0
    skip = 0
    N = len(elements)
    # print(" - N: %d ------ " %N)
    for k in key:
        # select from idx to idx + k => selection 
        # print(" ----- k: %d ------ " %k)
        # print(" el: ", elements)
        end = (idx + k-1) % N

        #- case 1: idx < end
        #- case 2: idx > end 
        #- case 3: idx = end

        finished = False
        inOrder = False
        if idx < end:
            inOrder = True

        if idx == end:
            finished = True
        if k == 0:
            finished = True
        # reverse selection
        #- case 1: 
        i = idx
        j = end
        while not inOrder and not finished:
            # print('exchanging (a) (i,j) = ', i, j)
            elements[i], elements[j] = elements[j],elements[i]
            i += 1
            j -= 1
            if i > N-1 and j < 0:
                inOrder = True
                finished = True
            if i > N-1:
                i = 0
                inOrder = True
            if j < 0:
                j = N-1
                inOrder = True
        while i < j and inOrder and not finished:
            # print('exchanging (b) (i,j) = ', i, j)
            elements[i], elements[j] = elements[j],elements[i]
            i += 1
            j -= 1
        
        # move idx. idx = idx + k + skip
        idx = (idx + k + skip) % N

        # skip = skip + 1
        skip += 1


    return elements


if __name__ == "__main__":
    print("-- test --")
    elements = [0,1,2,3,4]
    key = [3, 4, 1, 5]

    print( "before ", elements )
    elements = process( elements, key )
    print( "after", elements )


    print("-- real case --")

    f = open('input.txt', 'r')
    line = f.readlines()[0]
    line = line.rstrip()
    line = [int(x) for x in line.split(',')]
    # print(line)
    key = line
    
    print(key)
    elements = [ x for x in range(256)]
    #print( "before ", elements )
    elements = process( elements, key )
    #print( "after", elements )

    multiplication = elements[0] * elements[1]
    print("multipl of the first two: ", multiplication)

    print("======= part 2 ======")
    print("--- test ---")
    elem = ['0','1','2','3','4']
    real_elem = [ord(x) for x in elem]
    addition = [ 17, 31, 73, 47, 23]
    real_elem = real_elem+ addition[:]
    print(real_elem)
