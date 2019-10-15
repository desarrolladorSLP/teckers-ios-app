//
//  ViewController.swift
//  teckersDeliverable
//
//  Created by Maggie Mendez on 10/7/19.
//  Copyright © 2019 Maggie Mendez. All rights reserved.
//

import UIKit

class DeliverablesController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let status: [statusDeliverables] = [.toDo, .accepted, .blocked, .inProgress, .overdue, .readyForReview, .rejected, .rejected, .rejected, .rejected ]
    
    var deliverables: [Deliverable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let nibName2 = UINib(nibName: "DeliverableCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier: "DeliverableCell")
        let json = """
        [
            {
               "title" : "Deliverable",
               "description" : "Deliverable description",
               "status" : 1,
               "resources" : []
           },
           {
               "title" : "Deliverable",
               "description" : "Deliverable description",
               "status" : 2,
               "resources" : []
           },
           {
               "title" : "Deliverable",
               "description" : "Deliverable description",
               "status" : 3,
               "resources" : []
           },
           {
               "title" : "Deliverable",
               "description" : "Deliverable description",
               "status" : 4,
               "resources" : []
           },
           {
               "title" : "Deliverable",
               "description" : "Deliverable description",
               "status" : 5,
               "resources" : []
           },
           {
               "title" : "Deliverable",
               "description" : "Deliverable description",
               "status" : 6,
               "resources" : []
           }
        ]
        """.data(using: .utf8)!
        
        do{
            deliverables = try JSONDecoder().decode([Deliverable].self, from: json)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
extension DeliverablesController: UITableViewDelegate{
    
}

extension DeliverablesController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliverables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath)
        
        if let deliverableCell = cell as? SecondTableViewCell{
            deliverableCell.status = status[indexPath.row]
            deliverableCell.type = (indexPath.row % 2 != 0) ? .right: .left
            deliverableCell.deliverable = deliverables[indexPath.row]
        }
        return cell
    }
}

