//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by MTQ on 8/2/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let urlAPI = "http://localhost:2403/infor"
    
    var myCourse: MyCourse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        reloadData()
    }
    
    func reloadData() {
        DataServices.shared.get(urlAPI, completion: { json in
            guard let json = json as? [Dictionary<String, Any>] else {
                return
            }
            self.myCourse = ParserData().parseCourse(json)
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Unwind Segue
    @IBAction func unwindFromDetailVC(_ segue: UIStoryboardSegue) {
        if segue.identifier == "unwindFromDetailVC" {
            guard let detailVC = segue.source as? DetailViewController else {
                return
            }
            guard let nameOfCourse = detailVC.textField.text else {
                return
            }
            let param = ["course": nameOfCourse]
            DataServices.shared.post(urlAPI, param: param, completion: {
                self.reloadData()
            })
        }
    }

}

// MARK: - UITableViewDataSource
extension TableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let idOfCourse = myCourse!.courses[indexPath.row].id
            let param = ["id": idOfCourse]
            DataServices.shared.delete(urlAPI, param: param, completion: {
                self.reloadData()
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCourse?.courses.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let course = myCourse?.courses[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = course.name
        
        return cell
    }
}

// MARK: - Model
struct Course {
    let name: String
    let id: String
}

struct MyCourse {
    var courses: [Course]
}

