
def processInput( lines ):
    firewall = []
    depth = 0
    for line in lines:
        parts = line.split(':')
        depth_n = int(parts[0])
        range_n = int(parts[1])

        while depth < depth_n:
            firewall.append([])
            depth += 1
        firewall.append([0]*range_n)
        depth += 1
    return firewall


if __name__ == "__main__":
    print("- - - test - - -")
    testLines = [
                "0: 3",
                "1: 2",
                "4: 4",
                "6: 4"
                ]

    firewall = processInput( testLines )
    print(firewall)
