// SBT-Lesson-7 Homework-Task-1

import UIKit

// MARK: - Задача 1 "Сделать так, чтобы закомментиррованный код работал"

/**
 My solution is down. Ray Wenderlich helped me little bit :)
 */

protocol Summable { static func +(lhs: Self, rhs: Self) -> Self } // Create new protocol
extension Double: Summable {} // Clarify that Double type conforms to protocol Summable
extension String: Summable {} // The same action for String type for our task

// Change type constraint from Numeric to Summable
func sumTwoValues<T: Summable>(_ a: T, _ b: T) -> T {
    let result = a + b
    return result
}

let a = 25.0
let b = 34.0

let resultDouble = sumTwoValues(a, b)
print(resultDouble)

let c = "ABC"
let d = "DEF"

let resultString = sumTwoValues(c, d)
print(resultString)
