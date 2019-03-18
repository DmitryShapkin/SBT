// SBT-Lesson-7 Homework-Task-3 Another Implementation

import UIKit

// As a sample I add to my previous homework (SBT-Lesson-7 Task-3) this simple enum of linked list in addition

enum List<T> {
    indirect case Cons(T, List<T>)
    case Nil
}

// Very simple linked list
let list = List.Cons(1, .Cons(2, .Cons(3, .Nil)))

// Wiki: The name of the constructor does not matter so much, but we have borrowed the name from the Lisp programming language, namely "cons"
