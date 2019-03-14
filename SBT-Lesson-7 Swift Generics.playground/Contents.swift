// SBT-Lesson-7 Swift Generics

import UIKit

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

// Let's create generic function:

func genericFunc<T>(_ a: inout T, _ b: inout T ) {
    let temporaryValue = a
    a = b
    b = temporaryValue
}

genericFunc(&a, &b)
print("a = \(a), b = \(b)")

genericFunc(&stringTwo, &stringOne)
print("stringOne = \(stringOne), stringTwo = \(stringTwo)")

/**
 Practice #2
 */

// Let's create a func with multiple placeholders

func showMyNameAndTodaysDate<S, D>(name: S, date: D) {
    print("Today is a \(date). And my name for today is \(name)")
}

let myName = "Dmitry Shapkin"
let todayAsDate = Date()

showMyNameAndTodaysDate(name: myName, date: todayAsDate)

let todayAsString = "14 марта 2019"
showMyNameAndTodaysDate(name: myName, date: todayAsString) // super!

/**
 Practice #3
 */

// Let's create a stack with Int values using struct

struct StackInt {
    var arrayOfInt = [Int]()
    
    mutating func push(_ someInt: Int) {
        arrayOfInt.append(someInt)
    }
    
    mutating func pop() -> Int {
        return arrayOfInt.removeLast()
    }
}

var stack = StackInt()
print(stack.arrayOfInt)
stack.push(5)
stack.push(7)
stack.push(9)
print(stack.arrayOfInt)
let lastElement = stack.pop()
print(lastElement)
print(stack.arrayOfInt)

// Let's create generic stack on the struct basis

struct GenericStack<Element> {
    var arrayOfValues = [Element]()
    
    mutating func push(_ newValue: Element) {
        arrayOfValues.append(newValue)
    }
    
    mutating func pop() -> Element {
        return arrayOfValues.removeLast()
    }
}

var genericStack = GenericStack<String>() // we should explicitly write the type
genericStack.push("My")
genericStack.push("name")
genericStack.push("is")
genericStack.push("Dmitry")
let lastWordInStack = genericStack.pop()
print(lastWordInStack)
print(genericStack)

/**
 Practice #4
 */

// Extending a generic
// let's  write a topItem property

extension GenericStack {
    var topItem: Element? {
        return arrayOfValues.isEmpty ? nil : arrayOfValues[arrayOfValues.count - 1]
    }
}

if let top = genericStack.topItem {
    print(top)
}

// Let's create my own dictionary using struct

struct MyOwnDictionary<Key, Value> where Key: Hashable {
    // some code
}

// We can require from type to be children of some class OR to work with some protocol

protocol SomeProtocol {
    // some protocol
}

class MyClass: SomeProtocol {
    var name: String?
}

func someFunction<T: UIView, U: SomeProtocol>(someT: T, someU: U) {
    print("someT = \(someT), someU = \(someU)")
}

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

let myObject = MyClass()

someFunction(someT: label, someU: myObject)


// Type Constraints in Action

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2"

// Let's create a generic for function above:

func findIndex<T: Equatable>(valueToFind: T, array: [T]) -> Int? {
    
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

findIndex(valueToFind: 7, array: [1,2,3,4,5,6,7,8])
findIndex(valueToFind: "Dmitry", array: ["Oleg", "Dmitry", "Alex"])


/**
 Practice #5
 */

// Associated type

protocol Container {
    associatedtype Item // declare
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


struct IntStack: Container {
    
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    
    typealias Item = Int
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

print("finish associatedtype")

protocol Container2 {
    associatedtype Item: Equatable // declare
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension Array: Container {
    
}

// Next one (doesn't understand this one yet)

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}


extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
// suffix contains 20 and 30
