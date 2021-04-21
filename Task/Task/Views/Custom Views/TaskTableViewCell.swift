//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Cynthia Nikolai on 4/21/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    // MARK:- Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK:- Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
    }
    
    // MARK:- Functions
    func updateViews() {
        guard let task = self.task else { return }
        taskNameLabel.text = task.taskName
        task.isComplete() ? completionButton..setBackgroundImage(UIImage(named: "incomplete"), for: .normal) : completionButton..setBackgroundImage(UIImage(named: "complete"), for: .normal)
        
    }
}
