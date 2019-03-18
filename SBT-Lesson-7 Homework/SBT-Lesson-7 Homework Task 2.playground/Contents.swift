// SBT-Lesson-7 Homework Task 2

/**
 В Playground SwiftGenerics_02 создать систему generic-типов. Типы могут быть свои либо можно использовать предложенный ниже вариант.
  
 “Реализовать базовый протокол для контейнеров. Контейнеры должны отвечать, сколько они содержат элементов (1), добавлять новые элементы (2) и возвращать элемент по индексу (3). На основе базового протокола реализовать универсальный связанный список и универсальную очередь (FIFO) в виде структуры или класса. ”
 */

import UIKit

// Create my own protool

protocol BaseProtocol {
    associatedtype Element
    var count: Int { get }
    mutating func append(_ value: Element) // "mutating" - just in case if we will use "struct" in the future
    subscript(index: Int) -> Element { get }
}

/**
 LINKED LIST as class
 (based on BaseProtocol)
 */

class LinkedList<T>: BaseProtocol {

    class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    typealias Element = LinkedListNode<T>
    
    // Create head
    var head: Element?
    
    // Create last element
    
    var last: Element? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    // Task 1 (сколько они содержат элементов):
    
    var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    // Task 2 (добавлять новые элементы)
    
    // Append to the end of Linked List:
    func append(_ value: T) {
        let newNode = Element(value: value)
        append(newNode) // Call the function below
    }
    
    // Logic for append
    func append(_ node: Element) {
        let newNode = node
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    // Task 3 (возвращать элемент по индексу)
    
    subscript(index: Int) -> Element {
        let node = self.node(at: index)
        return node
    }
    
    func node(at index: Int) -> Element {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node!
        }
    }
}

// Realization:
let kaschenkoPatients = LinkedList<String>()
kaschenkoPatients.append("Наталья морская пехота")
kaschenkoPatients.append("Доктор Попов")
kaschenkoPatients.append("Кандибобер")
kaschenkoPatients.append("Дудь")

print(kaschenkoPatients)
print(kaschenkoPatients[0].value) // По индексу получаем элемент и далее его value
print(kaschenkoPatients.head!.value) // using force unwrap just for sample
print(kaschenkoPatients.last!.value) // using force unwrap just for sample
print(kaschenkoPatients.count)

// To create the same Linked List but as struct:
// 1. Just add to "append" func keyword "mutating" because this func change head (line 74, 80)
// 2. Change let to var (line 114)
