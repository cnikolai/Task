//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Cynthia Nikolai on 4/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        TaskController.sharedInstance.loadFromPersistenceStore()
    }
    
    // MARK:- Properties
    var task: Task?

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }

        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
        // cell.task = task
        cell.updateViews(for: task)
        
        // Step 3: Assigning the delegate
        cell.delegate = self
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let task = self.task
        guard let destinationVC = segue.destination as? TaskDetailViewController else { return }
        destinationVC.task = task

        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let task = TaskController.sharedInstance.tasks[indexPath.row]
        
            destinationVC.task = task
        }
    }
}//end of class

// MARK:- Extension
// Step 4: using an extension, conform TaskListTableVC to the TaskCompletionDelegate
extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(for cell: TaskTableViewCell) {
        // Get the indexPath for the cell that was selected
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        // Grabbing the setting from the source of truth at the index of the selected cell
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        // Calling .toggleIsOn function to toggle the isOn property of the passed in setting
        TaskController.sharedInstance.toggleIsComplete(task: task)
        // Call the updateViews function on our cell to update the view and reflect the newly changed isOn property
        cell.updateViews(for: task)
    }
    
   
}
