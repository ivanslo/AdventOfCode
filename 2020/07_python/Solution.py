import re
import pprint

pp = pprint.PrettyPrinter(indent=2)


def makeDict( ls: [str]) ->( dict, dict):
	bagsInBag = {}
	oppositeBags = {}

	for line in ls:
		m1 = re.match(r'(.*) bags contain (.*).', line)
		bag = m1.groups()[0]

		bagsInBag[bag] = bagsInBag.get(bag, [])
		rests = m1.groups()[1]

		if rests == 'no other bags':
			continue

		for rest in rests.split(', '):
			m2 = re.match(r'(\d+) (.*) (bag|bags)', rest)
			q = int(m2.groups()[0])
			b = m2.groups()[1]
			bagsInBag[bag].append((b, q))

			oppositeBags[b] = oppositeBags.get(b, [])
			oppositeBags[b].append(bag)
	return bagsInBag, oppositeBags


def howManyContain( key:str, od: dict, res = set() ) -> int:
	for container in od.get(key, []):
		res.add(container)
		howManyContain( container, od )
	return len(res)

def howManyBagsWithin( key:str, bb: dict ) -> int:
	conts = bb.get(key)
	if len(conts) == 0:
		return 0

	res = 0
	for cont in conts:
		res += cont[1] + cont[1] * howManyBagsWithin(cont[0], bb)

	return res



def solution1( ls: [str]) -> int:
	bb, oo = makeDict(ls)
	n = howManyContain('shiny gold', oo)
	return n

def solution2( ls: [str]) -> int:
	bb, oo = makeDict(ls)
	n = howManyBagsWithin('shiny gold', bb)
	return n
