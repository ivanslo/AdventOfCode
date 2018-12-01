# Part 1
changes = [int(n.strip()) for n in input.split() if n.strip()]
print(sum(changes))

# Part 2
from itertools import accumulate, cycle
seen = set()
print(next(f for f in accumulate(cycle(changes)) if f in seen or seen.add(f)))

