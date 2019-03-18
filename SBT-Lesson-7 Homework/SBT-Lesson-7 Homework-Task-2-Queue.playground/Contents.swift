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
    var count: Int { get }
    mutating func append(_ value: Element)
    subscript(index: Int) -> Element { get }
}

public struct Queue<T>: BaseProtocol {

    typealias Element = T
    
    fileprivate var array = [T]()
    
    // Task 1 (сколько они содержат элементов):
    public var count: Int {
        return array.count
    }
    
    // Task 2 (добавлять новые элементы)
    mutating func append(_ value: Element) {
        array.append(value)
    }
    
    // Task 3 (возвращать элемент по индексу)
    subscript(index: Int) -> Element {
        return array[index]
    }
}

// Realization:
var kaschenkoPatients = Queue<String>()
kaschenkoPatients.append("Наталья морская пехота")
kaschenkoPatients.append("Доктор Попов")
kaschenkoPatients.append("Кандибобер")
kaschenkoPatients.append("Дудь")

print(kaschenkoPatients)
print(kaschenkoPatients[0])
print(kaschenkoPatients.count)
