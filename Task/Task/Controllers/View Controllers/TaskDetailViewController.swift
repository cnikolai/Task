//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Cynthia Nikolai on 4/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK:- Properties
    var task: Task?
    var date: Date?
    
    // MARK:- Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK:- Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
            guard let taskName = taskNameTextField.text, !taskName.isEmpty,
                  let taskNotes = taskNotesTextView.text, !taskNotes.isEmpty,
                  let taskDate = taskDueDatePicker?.date else { return }
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: taskName, notes: taskNotes, dueDate: taskDate)
        } else {
            TaskController.sharedInstance.createTaskWith(name: taskName, notes: taskNotes, dueDate: taskDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    // MARK:- Functions
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.taskName
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()


    }
}
