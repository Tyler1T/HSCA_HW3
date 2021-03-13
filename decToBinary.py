# Python program to convert decimal to binary

# Function to convert Decimal number
# to Binary number
def decimalToBinary8(n):
    return format(n, "08b")

def decimalToBinary4(n):
    return format(n, "04b")

def decimalToBinary15(n):
    return format(n, "015b")

# Driver code
if __name__ == '__main__':
    f = open("testvector.tv", "w+")
    x = 0
    y = 0
    z = 0
    for i in range(0, 5):
        print("What is the first number to multiply by?")
        x = int(input())
        print("What is the second number to multiply by?")
        y = int(input())
        z = x*y
        f.write(decimalToBinary8(x))
        f.write("_")
        f.write(decimalToBinary4(y))
        f.write("_")
        f.write(decimalToBinary15(z))
        f.write("\n")
        print()
    f.close()
