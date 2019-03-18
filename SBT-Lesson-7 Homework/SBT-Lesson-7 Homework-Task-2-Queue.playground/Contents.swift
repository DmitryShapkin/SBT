// SBT-Lesson-7 Homework-Task-2-Queue

/**
 Важно! Пришлось создать этот (второй) файл для задачи #2, потому что Playground начал жутко тупить.
 
 Здесь реализуем очередь.
 Протокол создан точно такой же, как и в первом задании.
 */

import UIKit

// Create my own protool

protocol BaseProtocol {
    associatedtype Element
    associatedtype ReturnType
    var count: Int { get }
    mutating func append(_ value: Element)
    subscript(index: Int) -> ReturnType { get }
}

public struct Queue<T>: BaseProtocol {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}
