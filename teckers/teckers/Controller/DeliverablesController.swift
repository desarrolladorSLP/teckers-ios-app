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
    
    var deliverables: [Deliverable] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let nibName2 = UINib(nibName: "DeliverableCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier: "DeliverableCell")
        DeliverableService.getDeliverable(success: {[weak self] deliverableArray in
            self?.deliverables = deliverableArray
        })
    }
    
}
extension DeliverablesController: UITableViewDelegate{
    
}

extension DeliverablesController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliverables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliverableCell", for: indexPath)
        
        if let deliverableCell = cell as? DeliverableCell{
            deliverableCell.status = statusDeliverables(rawValue: deliverables[indexPath.row].status) ?? .none
            deliverableCell.type = (indexPath.row % 2 != 0) ? .right: .left
            deliverableCell.deliverable = deliverables[indexPath.row]
        }
        return cell
    }
}

