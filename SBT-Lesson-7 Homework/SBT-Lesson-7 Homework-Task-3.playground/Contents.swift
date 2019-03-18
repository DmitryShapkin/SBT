// SBT-Lesson-7 Homework-Task-3

// Create Linked List on the Enum basis

import UIKit

indirect enum LinkedListNode<T> {
    case value(element: T, next: LinkedListNode<T>)
    case end
}

extension LinkedListNode: Sequence {
    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(self)
    }
}

struct LinkedListIterator<T>: IteratorProtocol {
    var current: LinkedListNode<T>

    init(_ current: LinkedListNode<T>) {
        self.current = current
    }

    mutating func next() -> T? {
        switch current {
        case .value(let element , let next):
            self.current = next
            return element
        case .end:
            return nil
        }
    }
}

// Realization:
let list = LinkedListNode.value(element: "Хоп", next: .value(element: "Хэй", next: .value(element: "Ла-Ла-Лэй", next: .end)))

list.forEach { number in
    print(number)
}
