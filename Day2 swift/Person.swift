//
//  Person.swift
//  Day2 swift
//
//  Created by Kerolos on 27/04/2025.
//

import Foundation

class Person {
    var salary: Double
    
    init(salary: Double) {
        self.salary = salary
    }
    
    func getSalary() -> Double {
        return salary
    }
}

class Employee: Person {
    override func getSalary() -> Double {
        return salary * 2
    }
}

class Manager: Person {
    override func getSalary() -> Double {
        return salary * 4
    }
}
