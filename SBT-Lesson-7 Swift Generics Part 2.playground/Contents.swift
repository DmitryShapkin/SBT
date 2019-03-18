// This is part 2 for my pracice in Swift Generics (SBT-Lesson-7)

import UIKit



// Added type constraints

protocol Container {
    associatedtype Item: Equatable // here
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//extension Container {
//
//    /**
//     We can't declare new method in extension like this:
//     func myNewMethod()
//     We always should do a default realization for methods (in extension ofcourse)
//    */
//
//    func myNewMethod() {
//        print("something") // like this
//    }
//}

// I added Stack<Element: "Equatable"> on my own, otherwise compiler was mad af :)

struct Stack<Element: Equatable>: Container {
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

// We use inheritance in order to add new methods in protocol without realization (only declaration):
protocol SuffixableContainer: Container {
    // I tested. Just change SuffixableContainer to Container (below case) and nothing happened. The code is working yet.
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item // type of kind of array??? or what?
    // Trying to explan the code above:
    // Suffix - it is my own type (like Array) that conform to protocol SuffixableContainer
    // therefore Suffix conform to protocol Container
    // therefore
    
    func suffix(_ size: Int) -> Suffix
}

// Extension for the Stack type (line 31)

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

print(type(of: suffix))
