//
//  DeliverablesTekersController.swift
//  teckers
//
//  Created by Ricardo Granja on 16/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class DeliverablesTekersController: UIViewController {

    @IBOutlet weak var collectionViewDeriverables: UICollectionView!
    private let roles = UserInformation.shared.roles ?? []
    var teckers: [DeliverableTeckers] = [] {
        didSet{
            self.collectionViewDeriverables.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibCell = UINib(nibName: DeriverablesTeckersCell.nameCell, bundle: nil)
            collectionViewDeriverables.register(nibCell, forCellWithReuseIdentifier: DeriverablesTeckersCell.nameCell)
        
        if !roles.contains(Roles.Tecker.rawValue) {
            DeliverableService.getDeliverableTeckers(roles: roles, completion: { [weak self] deliverableArray, error  in
                if let teckersArray = deliverableArray {
                    self?.teckers = teckersArray
                }
                else if let Error = error {
                    let alertAction = Alert(title: "Error", massage: Error.localizedDescription)
                    self?.present(alertAction.showOK(), animated: true, completion: nil)
                }
            })
        }
        else {
            print("Pase a la otra pantalla")
        }
    }
}


extension DeliverablesTekersController: UICollectionViewDelegate {

}

extension DeliverablesTekersController: UICollectionViewDataSource {
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
            let _ = collectionViewDeriverables.cellForItem(at: indexPath)
            
            
        }
    }
}
