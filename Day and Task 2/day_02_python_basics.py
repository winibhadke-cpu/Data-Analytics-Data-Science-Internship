"""Day 2 - Python Basics | Data Analytics Internship.
Run: python day02_python_basics.py
Demonstration: python day02_python_basics.py --demo
"""
import sys


def calculator(a, b, operator):
    if operator == '+': return a + b
    if operator == '-': return a - b
    if operator == '*': return a * b
    if operator == '/':
        if b == 0: raise ValueError('Cannot divide by zero')
        return a / b
    raise ValueError('Operator must be +, -, *, or /')


def even_or_odd(n):
    return 'Even' if n % 2 == 0 else 'Odd'


def number_sign(n):
    return 'Positive' if n > 0 else 'Negative' if n < 0 else 'Zero'


def largest_of_three(a, b, c):
    return max(a, b, c)


def student_grade(marks):
    if not 0 <= marks <= 100: raise ValueError('Marks must be between 0 and 100')
    if marks >= 90: return 'A+'
    if marks >= 80: return 'A'
    if marks >= 70: return 'B'
    if marks >= 60: return 'C'
    if marks >= 50: return 'D'
    return 'F'


def multiplication_table(n):
    return [f'{n} x {i} = {n * i}' for i in range(1, 11)]


def factorial(n):
    if n < 0: raise ValueError('Factorial requires a non-negative integer')
    result = 1
    for i in range(2, n + 1): result *= i
    return result


def fibonacci(count):
    if count < 0: raise ValueError('Count must be non-negative')
    result, a, b = [], 0, 1
    for _ in range(count):
        result.append(a)
        a, b = b, a + b
    return result


def count_vowels(s):
    return sum(ch.lower() in 'aeiou' for ch in s)


def reverse_string(s):
    return s[::-1]


def demonstrate():
    cases = [
        ('1. Calculator', '12 + 8', calculator(12, 8, '+')),
        ('2. Even/Odd', '17', even_or_odd(17)),
        ('3. Positive/Negative', '-9', number_sign(-9)),
        ('4. Largest of Three', '12, 45, 23', largest_of_three(12, 45, 23)),
        ('5. Student Grade', '86', student_grade(86)),
        ('6. Multiplication Table', '5', '\n'.join(multiplication_table(5))),
        ('7. Factorial', '5', factorial(5)),
        ('8. Fibonacci Series', '7 terms', fibonacci(7)),
        ('9. Count Vowels', 'Data Analytics', count_vowels('Data Analytics')),
        ('10. Reverse String', 'Python', reverse_string('Python')),
    ]
    for name, inp, output in cases:
        print(f'\n{name}\nInput: {inp}\nOutput: {output}')


def main():
    actions = {
        '1': lambda: calculator(float(input('First number: ')), float(input('Second number: ')), input('Operator (+,-,*,/): ').strip()),
        '2': lambda: even_or_odd(int(input('Integer: '))),
        '3': lambda: number_sign(float(input('Number: '))),
        '4': lambda: largest_of_three(*[float(input(f'Number {i}: ')) for i in range(1, 4)]),
        '5': lambda: student_grade(float(input('Marks (0-100): '))),
        '6': lambda: '\n'.join(multiplication_table(int(input('Number: ')))),
        '7': lambda: factorial(int(input('Non-negative integer: '))),
        '8': lambda: fibonacci(int(input('Number of terms: '))),
        '9': lambda: count_vowels(input('Text: ')),
        '10': lambda: reverse_string(input('Text: ')),
    }
    while True:
        print('\nDAY 2 PYTHON BASICS | Choose program 1-10, D for demo, Q to quit')
        choice = input('Choice: ').strip().lower()
        if choice == 'q': break
        if choice == 'd': demonstrate(); continue
        if choice not in actions:
            print('Invalid choice.'); continue
        try:
            print('Result:', actions[choice]())
        except (ValueError, TypeError) as exc:
            print('Input error:', exc)


if __name__ == '__main__':
    if '--demo' in sys.argv:
        demonstrate()
    else:
        main()
