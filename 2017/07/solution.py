import re

""" algoritmo 
nodes = []

for each children (child):
    added = false
    for each element in nodes

        if child exists in element (recursive):
            element.add(child) (recursive) / update
            added = true
    if not added:
        add child to nodes
    
    newly added = child
    for each el in nodes (0...last):
        if el in nodes:
            update
            remove el from nodes

"""
import copy

def processInput( lines ):
    nodes = [] 
    for li in lines:
        spl = li.split(' ')
        name = spl[0]
        weight = int(re.sub(r'[(|)]', '', spl[1]))

        element = Element(name, weight)
        #print("%s %d" % (name, weight))
        for i in range(3,len(spl)):
            childName = spl[i].replace(',','')
            child = Element(childName)
            #print("  - child %s" % (childName))
            element.addChild(child)

        nodes.append(element)
    return nodes


def make_tree( nodes ):
    tree = Element('root')

    # add the nodes in order
    for node in nodes:
        if tree.contains(node):
            tree.update(node)
        else:
            tree.addChild(node)

    # re add the nodes until there's only one root-child
    limit = tree.getChildrenLen()
    i = 0
    while i < limit*2:
        child = tree.getFirstChild()
        if tree.contains(child):
            tree.update(child)
        else:
            tree.addChild(child)
        i = i+1

    return tree

def analyzeBalance( tree ):

    root = tree.getFirstChild()
    getWeight( root )
    pass


def getWeight( node ):
    weights = []
    for c in node.getChildren():
        weights.append( getWeight(c) )
    
    if difference(weights) > 0:
        print(" apa aca: %s %d %d " %(node.name, node.weight, difference(weights)))
        print("    children are :")

        for c in node.getChildren():
            print(" %s (%d) => (%d) ===> (+) %d" % (c.name, c.weight, c.subtreeWeight, c.subtreeWeight + c.weight))
        pass #todo mal
    
    node.setSubTreeWeight(sum(weights))

    return node.subtreeWeight + node.weight
            


def difference( ns ): #n = []
    if len(ns) == 0:
        return 0
    a = ns[0]
    for i in range(1,len(ns)):
        if ns[i] != a:
            return abs(ns[i] - a)
    return 0


# ---------------------------------------------------
class Element:
    def __init__(self, name, weight = 0):
        self.name = name
        self.weight = weight
        self.children = []
        self.subtreeWeight = 0

    def __eq__(self, other):
        return self.name == other.name
    
    def __ne__(self, other):
        return not self.__eq__(other)

    def addChild(self, element):
        self.children.append(element)

    def getName(self):
        return self.name

    def getChildren(self):
        return self.children

    def getChild(self, name):
        el = Element(name)
        return self.children[self.children.index(el)]

    def getFirstChild(self):
        child = self.children.pop(0)
        return child

    def getChildrenLen(self):
        return len(self.children)

    def setWeight(self, weight):
        self.weight = weight

    def setSubTreeWeight(self, weight):
        self.subtreeWeight = weight

    # recursive functions
    # -- contains
    def contains(self, other):
        if self == other:
            return True
        
        for c in self.children:
            inChild = c.contains(other)
            if inChild == True:
                return True

        return False

    def update(self, other):
        if self == other:
            if self.weight == 0:
                self.weight = other.weight
            if self.getChildrenLen() == 0:
                self.children = other.getChildren()
        else:
            for c in self.children:
                c.update(other)

    def getString(self, lvl=0):
        string = ""
        for c in self.children:
            string = string + c.getString(lvl+1) 
        
        myStr = "-"*lvl*2
        myStr = myStr + " (%s (%d)) " % (self.name, self.weight)
        
        return myStr + "\n" + string

    def __str__(self):
        return self.getString(0)

# ---------------------------------------------------

if __name__ == '__main__':
	input1 = [
		'pbga (66)',
		'xhth (57)',
		'ebii (61)',
		'havc (66)',
		'ktlj (57)',
		'fwft (72) -> ktlj, cntj, xhth',
		'qoyq (66)',
		'padx (45) -> pbga, havc, qoyq',
		'tknk (41) -> ugml, padx, fwft',
		'jptl (61)',
		'ugml (68) -> gyxo, ebii, jptl',
		'gyxo (61)',
		'cntj (57)'
	]
	nodes = processInput(input1)

	#print("nodes =>")
        #for node in nodes:
        #    print("%s" % (str(node)))
        tree = make_tree(nodes)
        print("tree => %s " %(str(tree)))

        disbalance = analyzeBalance(tree)
        print("disbalance is", disbalance)

        f = open('input.txt','r')
        lines = f.readlines()
        lines = [l.rstrip() for l in lines]
        f.close()

        nodes = processInput(lines)
        tree = make_tree(nodes)
        print("tree => %s " %(str(tree)))

        disbalance = analyzeBalance(tree)
        print("disbalance is", disbalance)
