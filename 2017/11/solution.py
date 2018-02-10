opposite = {
        'sw': 'ne',
        's' : 'n',
        'se': 'nw',
        'ne': 'sw',
        'n' : 's',
        'nw': 'se' }

doubled = {
        'se':'sw',
        'sw':'se',
        'nw':'ne',
        'ne':'nw'
        }

def ___steps( path ):
    taken = []

    for step in path:
        if opposite[step] in taken:
            taken.pop(taken.index(opposite[step]))
        elif len(step) > 1 and doubled[step] in taken:
            taken.pop(taken.index(doubled[step]))
            taken.append(step[0])
        else:
            taken.append(step)


    return len(taken)

from functools import reduce

def steps( path ):
    m = {
        'n' : 0,
        's' : 0,
        'e' : 0,
        'w' : 0
    }
    opposite = {
            'n':'s',
            's':'n',
            'e':'w',
            'w':'e'
            }
    for step in path:
        if len(step) == 1:
            m[step] += 2
        else:
            for direction in step:
                m[direction] += 1
    
    # reduction
    for v in m.keys():
        if m[v] != 0 and m[v] <= m[opposite[v]]:
            m[opposite[v]] -= m[v]
            m[v] = 0
    
    # compute
    su = reduce( (lambda x,key: x + m[key]), m, 0 ) 
    if su % 2 > 1:
        print('error!')
    return su / 2

def steps( path ):
    m = {
        'n' : 0,
        's' : 0,
        'e' : 0,
        'w' : 0
    }
    opposite = {
            'n':'s',
            's':'n',
            'e':'w',
            'w':'e'
            }
    furthest = 0

    for step in path:
        if len(step) == 1:
            m[step] += 2
        else:
            for direction in step:
                m[direction] += 1
    
        # reduction
        for v in m.keys():
            if m[v] != 0 and m[v] <= m[opposite[v]]:
                m[opposite[v]] -= m[v]
                m[v] = 0
    
        stepsaway = reduce( (lambda x,key: x + m[key]), m, 0 ) / 2
        if stepsaway > furthest:
            furthest = stepsaway
    
    return reduce((lambda x,key: x+m[key]), m, 0) / 2, furthest






if __name__ == '__main__':
    print("-- tests")
    tests = [
            ['ne','ne','ne'],
            ['ne','ne','sw','sw'],
            ['ne','ne','s','s'],
            ['se','sw','se','sw','sw']
            ]

    for case in tests:
        print(' - test: %s' % case)
        print(' -- steps: %d, %d' % steps(case))


    print('-- input')
    f = open('input','r')
    line = f.readlines()[0]
    f.close()
    line = line.rstrip()
    line = line.split(',')

    print(' -- steps: %d, %d' % steps(line))
    #print(' -- furthest: %d' %furthest(line))
