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
    
    func setup(with deliverablesArray: [Deliverable]) {
        self.deliverables = deliverablesArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let nibName2 = UINib(nibName: DeliverableCell.nameCell, bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier: DeliverableCell.nameCell)
    }
    
}
extension DeliverablesController: UITableViewDelegate{
    
}

extension DeliverablesController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliverables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliverableCell.nameCell, for: indexPath)
        
        if let deliverableCell = cell as? DeliverableCell{
            deliverableCell.status = statusDeliverables(rawValue: deliverables[indexPath.row].status) ?? .none
            deliverableCell.type = (indexPath.row % 2 != 0) ? .right: .left
            deliverableCell.deliverable = deliverables[indexPath.row]
        }
        
        return cell
    }
}

