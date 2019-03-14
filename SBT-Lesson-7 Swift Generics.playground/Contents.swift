// SBT-Lesson-7 Swift Generics

/**
 Practice #1
 */

// Problem

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = 5
var b = 7

print("a = \(a), b = \(b)")

swapTwoInts(&a, &b) // just swapping two integers

print("a = \(a), b = \(b)")

// let's try the function above on the String values

var stringOne = "Dmitry"
var stringTwo = "Shapkin"

// Can't do this because the func is waiting for Int values:
// swapTwoInts(&stringOne, &stringTwo)
// print("stringOne = \(stringOne), stringTwo = \(stringTwo)")

// We should do the another func for String values etc.. It's pretty boring

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

swapTwoStrings(&stringOne, &stringTwo)
print("stringOne = \(stringOne), stringTwo = \(stringTwo)")
