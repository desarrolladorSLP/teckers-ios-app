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
    var teckers: [Tecker] = [] {
        didSet{
            collectionViewDeriverables.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibCell = UINib(nibName: DeriverablesTeckersCell.nameCell, bundle: nil)
        collectionViewDeriverables.register(nibCell, forCellWithReuseIdentifier: DeriverablesTeckersCell.nameCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DeliverablesController {
            destination.setup(with: deliverables)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeriverablesTeckersCell.nameCell, for: indexPath)
        
        guard let cellTecker = cell as? DeriverablesTeckersCell else { return cell }
        cellTecker.tecker = self.teckers[indexPath.row]
        return cellTecker
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewDeriverables {
            let idTecker = teckers[indexPath.row].teckerId
//            self.performSegue(withIdentifier: Segues.toDeliverables.rawValue, sender: indexPath.row)
            DeliverableService.getDeliverableId(id: idTecker, success: { [weak self] response in
                self?.deliverables = response
                self?.performSegue(withIdentifier: Segues.toDeliverables.rawValue, sender: indexPath.row)
            }){ error in
                print(error.localizedDescription)
            }
        }
    }
}
