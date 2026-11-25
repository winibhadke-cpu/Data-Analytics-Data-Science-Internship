"""Day 3: Functions and Advanced Python Basics.
Run: python day03_python_functions.py
No third-party packages required.
"""
from math import ceil


def validate_marks(marks):
    """Return validated marks between 0 and 100."""
    if not marks:
        raise ValueError("At least one mark is required.")
    if any(isinstance(mark, bool) or not isinstance(mark, (int, float)) for mark in marks):
        raise TypeError("All marks must be numeric.")
    if any(mark < 0 or mark > 100 for mark in marks):
        raise ValueError("Marks must be between 0 and 100.")
    return marks


def calculate_average(marks):
    """Calculate mean marks."""
    validate_marks(marks)
    return sum(marks) / len(marks)


def calculate_max(marks):
    """Find highest mark."""
    validate_marks(marks)
    return max(marks)


def calculate_min(marks):
    """Find lowest mark."""
    validate_marks(marks)
    return min(marks)


def calculate_percentage(marks, maximum_per_subject=100):
    """Return obtained marks as a percentage of available marks."""
    validate_marks(marks)
    if isinstance(maximum_per_subject, bool) or not isinstance(maximum_per_subject, (int, float)) or maximum_per_subject <= 0:
        raise ValueError("Maximum per subject must be a positive number.")
    if any(mark > maximum_per_subject for mark in marks):
        raise ValueError("A mark exceeds the subject maximum.")
    return sum(marks) / (len(marks) * maximum_per_subject) * 100


def calculate_grade(percentage):
    """Example grading scale: A >=90, B >=75, C >=60, D >=40, F otherwise."""
    if isinstance(percentage, bool) or not isinstance(percentage, (int, float)):
        raise TypeError("Percentage must be numeric.")
    if not 0 <= percentage <= 100:
        raise ValueError("Percentage must be between 0 and 100.")
    if percentage >= 90:
        return "A"
    if percentage >= 75:
        return "B"
    if percentage >= 60:
        return "C"
    if percentage >= 40:
        return "D"
    return "F"


def main():
    print("DAY 3 - FUNCTIONS AND ADVANCED PYTHON BASICS")
    marks = [78, 85, 92, 88, 77]
    percentage = calculate_percentage(marks)
    print("Marks:", marks)
    print(f"Average: {calculate_average(marks):.2f}")
    print(f"Maximum: {calculate_max(marks)}")
    print(f"Minimum: {calculate_min(marks)}")
    print(f"Percentage: {percentage:.2f}%")
    print(f"Grade: {calculate_grade(percentage)}")

    print("\nADVANCED PYTHON EXAMPLES")
    square = lambda x: x * x  # Demonstration of lambda syntax
    print("Lambda square of 6:", square(6))
    print("map() doubled marks:", list(map(lambda x: x * 2, marks)))
    print("filter() marks >= 80:", list(filter(lambda x: x >= 80, marks)))
    print("List comprehension squares:", [x ** 2 for x in range(1, 6)])
    print("Dictionary comprehension:", {f"Subject {i}": mark for i, mark in enumerate(marks, start=1)})
    print("math module ceil(82.4):", ceil(82.4))
    try:
        calculate_average([])
    except ValueError as error:
        print("Exception handling:", error)


if __name__ == "__main__":
    main()
