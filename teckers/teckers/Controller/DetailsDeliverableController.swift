//
//  DetailsDeliverableController.swift
//  teckers
//
//  Created by Maggie Mendez on 21/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class DetailsDeliverableController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var deliverable: Deliverable? {
        didSet{
            if let deliverable = deliverable{
                let formatter = DateFormatter()
                formatter.dateFormat = TypeDateFormat.dayMonthYear.rawValue
                fields = [ deliverable.title,
                           deliverable.description ?? ""  ,
                           deliverable.status?.rawValue ?? "",
                           "Fecha de Entrega: \(formatter.string(from: deliverable.date ?? Date()))",
                            (false).description ]
                self.detailsTableView?.reloadData()
            }
        }
    }
    var fields: [String]?
    let nameCell = String(DetailsDeliverableCell.description().split(separator: ".").last ?? "")
    var nibname: UINib? {
        return UINib(nibName: nameCell,  bundle: nil)
    }
    var postName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        self.detailsTableView?.reloadData()

    }
    func setupTableview(){
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(nibname, forCellReuseIdentifier: nameCell)
    }
    @IBAction func goToPost(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToPost.rawValue, sender: self)
    }
    func setDeliverable(with id: String){
        DeliverableService.getOneDeliverable(for: id, onSuccess: {[weak self] (deliverable) in
            self?.deliverable = deliverable
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
extension DetailsDeliverableController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostDeliverableController{
            destination.delverable = deliverable
        }
    }
}
extension DetailsDeliverableController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fields?.count ?? 0) 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let details = fields, let type = detailsTypeCell(rawValue: indexPath.row ) else  { return UITableViewCell() }
        let item = details[indexPath.row]
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath)
        if let cell = cell  as? DetailsDeliverableCell{
            cell.setup( type, item)
        }
        return cell
    }
}
