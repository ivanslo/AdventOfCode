def processInput( lines ):
    tree = { }
    for line in lines:
        elements = line.split(' ')
        node = elements[0]

        connections = []
        for c in elements[2:]:
            c = c.replace(',','')
            connections.append(c)

        tree[node] = connections
    return tree


def calculateFrom(tree, key, visited=[]):
    visited.append(key)
    for child in tree[key]:
        if child not in visited:
            calculateFrom(tree, child, visited)
    return visited

def calculateGroups( tree ):
    groups_visited = []
    for key in tree.keys():
        visited = [ v for group in groups_visited for v in group ]
        if key not in visited:
            groups_visited.append( calculateFrom(tree,key,[]))
    return groups_visited



if __name__ == "__main__":
    testInput1 = [
        "0 <-> 2",
        "1 <-> 1",
        "2 <-> 0, 3, 4",
        "3 <-> 2, 4",
        "4 <-> 2, 3, 6",
        "5 <-> 6",
        "6 <-> 4, 5"
    ]
    tree = processInput(testInput1)

    visited = calculateFrom(tree, '0')
    groups = calculateGroups(tree)
    print(len(visited), " groups ", len(groups))

    
    f = open('input','r')
    lines = f.readlines()
    f.close()
    lines = [ l.rstrip() for l in lines]

    tree = processInput(lines)

    visited = calculateFrom(tree, '0', [])
    groups = calculateGroups(tree)
    print(len(visited), " groups ", len(groups))
