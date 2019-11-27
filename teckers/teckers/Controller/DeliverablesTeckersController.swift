//
//  DeliverablesTeckersController.swift
//  teckers
//
//  Created by Ricardo Granja on 16/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class DeliverablesTeckersController: UIViewController {

    @IBOutlet weak var collectionViewDeriverables: UICollectionView!
    private let roles = UserDefaults.standard.array(forKey: TokenKeys.Roles.rawValue) as? [String]
    var deliverables: [Deliverable] = []
    var teckers: [DeliverableTeckers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibCell = UINib(nibName: DeriverablesTeckersCell.nameCell, bundle: nil)
        collectionViewDeriverables.register(nibCell, forCellWithReuseIdentifier: DeriverablesTeckersCell.nameCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toDeliverables.rawValue {
            let teckersDeriverables = segue.destination as! DeliverablesController
            teckersDeriverables.setup(with: deliverables)
        }
    }
}


extension DeliverablesTeckersController: UICollectionViewDelegate {

}

extension DeliverablesTeckersController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teckers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeriverablesTeckersCell.nameCell, for: indexPath) as! DeriverablesTeckersCell
        
        DeriverablesTeckersCell.downloadImage(urlString: teckers[indexPath.row].imageUrl, completion: { data, error in
            if let Error = error {
                let alertAction = Alert(title: "Error", massage: Error.localizedDescription)
                self.present(alertAction.showOK(), animated: true, completion: nil)
            }
            else if let Data = data {
                cell.commitInit(data: Data, name: self.teckers[indexPath.row].name)
            }
        })
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewDeriverables {
            let idTecker = teckers[indexPath.row].teckerId
            
            DeliverableService.getDeliverableId(id: idTecker, success: { [weak self] response in
                self?.deliverables = response
                self?.performSegue(withIdentifier: Segues.toDeliverables.rawValue, sender: indexPath.row)
            })
        }
    }
}
