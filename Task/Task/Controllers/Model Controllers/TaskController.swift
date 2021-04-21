//
//  TaskController.swift
//  Task
//
//  Created by Cynthia Nikolai on 4/21/21.
//

import Foundation

class TaskController {
    
    static var sharedInstance = TaskController()
    // MARK:- Properties
    var tasks: [Task] = []
    // MARK:- CRUD
    // Create
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(taskName: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    // Update
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.taskName = name
        task.notes = notes
        task.dueDate = dueDate
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    // Read
    func toggleIsComplete(task: Task) {
        task.isComplete = !task.isComplete
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    // MARK:- Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPersistenceStore())
        } catch {
            //print("Error encoding songs")
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}
