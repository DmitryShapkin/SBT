//
//  LinkedList.swift
//  ObjectiveCWithSwiftFile
//
//  Created by Dmitry Shapkin on 19/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

import UIKit

// Adapter for my Generic Swift Class
class LinkedListForObjC: NSObject {
    
    private let internalLinkedList = LinkedList<String>()
    
    @objc var count: Int {
        return internalLinkedList.count
    }
    
    @objc var head: String {
        return internalLinkedList.head?.value ?? "Dima, your LinkedList is empty."
    }
    
    @objc var last: String {
        return internalLinkedList.last?.value ?? "Last element doesn't exist."
    }
    
    @objc func append(_ value: String) {
        internalLinkedList.append(value)
    }
    
    @objc subscript(i: Int) -> String? {
        return internalLinkedList[i].value
    }
}

// My Swift Class from previous task (SBT-Lesson-7 Task-2-LinkedList)
class LinkedList<T>: NSObject {
    
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
