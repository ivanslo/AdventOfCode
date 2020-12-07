import re
import pprint

pp = pprint.PrettyPrinter(indent=2)

def parseLine( line: str )  -> (str, [(int,str)]):
	m1 = re.match(r'(.*) bags contain (.*).', line).groups()
	bag = m1[0]
	content = filter(lambda x: x != None, [re.match(r'(\d+) (.*) (bag|bags)', x) for x in m1[1].split(', ')])
	return bag,content

def makeDict( ls: [str]) -> dict:
	bb = {}
	for line in ls:
		bag, content = parseLine(line)
		bb[bag] =  bb.get(bag, [])
		list(map(lambda gr: bb[bag].append((gr.groups()[1], int(gr.groups()[0]))), content))
	return bb

def invertDict( a : dict ) -> dict:
	o = {}
	for k in a.keys():
		for kk,val in a[k]:
			o[kk] = o.get(kk, [])
			o[kk].append(k)
	return o

def howManyContain( key:str, od: dict, res = set() ) -> int:
	for container in od.get(key, []):
		res.add(container)
		howManyContain( container, od, res )
	return len(res)

def howManyBagsWithin( key:str, bb: dict ) -> int:
	res = 0
	for cont in bb.get(key):
		res += cont[1] + cont[1] * howManyBagsWithin(cont[0], bb)

	return res



def solution1( ls: [str]) -> int:
	bb = makeDict(ls)
	oo = invertDict(bb)
	n = howManyContain('shiny gold', oo)
	return n

def solution2( ls: [str]) -> int:
	bb = makeDict(ls)
	n = howManyBagsWithin('shiny gold', bb)
	return n
