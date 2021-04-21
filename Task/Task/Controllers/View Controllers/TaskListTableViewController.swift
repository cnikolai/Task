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
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)

        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
        cell.textLabel?.text = task.taskName
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
 

}
