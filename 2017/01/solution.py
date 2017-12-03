"""
The captcha requires you to review a sequence of digits (your puzzle input) and find the sum of all digits that match the next digit in the list. The list is circular, so the digit after the last digit is the first digit in the list.

For example:

    1122 produces a sum of 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit.
    1111 produces 4 because each digit (all 1) matches the next.
    1234 produces 0 because no digit matches the next.
    91212129 produces 9 because the only digit that matches the next one is the last digit, 9.

What is the solution to your captcha?
"""

def solution( chain ):
    #return solve( chain )
    #return captcha1( chain )
    # calculates the sum
    if len(chain) == 0:
        return 0

    total = 0
    for i,c in enumerate(chain):
        nxt = (i+1) % len(chain)
        nxt = i-1 
        #nxt = int(len(chain)/2)
        if c == chain[nxt]:
            total = total + int(c)
    return total


#def solve(input):
#    elements = list(zip(input[1:], input)) + [(input[0], input[-1:])]
#    return reduce(lambda x, y: x + (int(y[0]) if y[0] == y[1] else 0), elements, 0)
# from internet 
#def captcha1( digits ):
#    return sum(int(digits[i]) 
#        for i in range(len(digits)) 
#        if digits[i] == digits[(i+1)%len(digits)]) 


if __name__ == "__main__":
    # tests
    print( "-- tests --" )
    print( "1122 => ", solution("1122") )
    print( "1111 => ", solution("1111") )
    print( "1234 => ", solution("1234") )
    print( "91212129 => ", solution("91212129") )

    print( "-- input --" )
    with open('input.txt', 'r') as f:
        line = f.readlines()[0]
        print(" Solution => ", solution(line))


