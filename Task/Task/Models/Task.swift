//
//  Task.swift
//  Task
//
//  Created by Cynthia Nikolai on 4/21/21.
//

import Foundation
 
class Task: Codable {
    var taskName: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    let uuid: String
    
    init(taskName: String, notes: String?, dueDate: Date?, isComplete: Bool = false, uuid: String = UUID().uuidString) {
        self.taskName = taskName
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
        self.uuid = uuid
    }
}

// MARK:- Extensions
extension Task: Equatable {
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
