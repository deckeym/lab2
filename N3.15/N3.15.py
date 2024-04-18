def reglament_check(num):
    prev_digit = num % 10
    num = num // 10
    while num != 0:
        current_digit = num % 10
        if current_digit <= prev_digit:
            prev_digit = current_digit
            num //= 10
        else:
            return False
    return True

def num_reverser(num):
    if reglament_check(num):
        reversed_num = 0
        while num != 0:
            reversed_num = reversed_num * 10 + num % 10
            num //= 10
        return reversed_num
    else:
        return 0

# Заранее заданные числа
numbers = [1234, 4321, 9876, 6789]

for number in numbers:
    print(num_reverser(number), end=" ")
print()