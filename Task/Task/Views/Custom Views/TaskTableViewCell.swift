//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Cynthia Nikolai on 4/21/21.
//

import UIKit

// Step 1
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(for cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    var task: Task? {
        didSet {
            updateViews(for: task!)
        }
    }
    // Step 2
    weak var delegate: TaskCompletionDelegate?
    
    // MARK:- Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK:- Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        // Step 5
        delegate?.taskCellButtonTapped(for: self)
    }
    
    // MARK:- Functions
    func updateViews(for task: Task) {
        taskNameLabel.text = task.taskName
        task.isComplete ? completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal):completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
    
    }
}
