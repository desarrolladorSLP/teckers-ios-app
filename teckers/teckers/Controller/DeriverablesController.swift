//
<<<<<<< HEAD
//  DeliverablesTekersController.swift
=======
//  DeriverablesViewController.swift
>>>>>>> Deliverables display with full display
//  teckers
//
//  Created by Ricardo Granja on 16/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class DeliverablesTekersController: UIViewController {

    @IBOutlet weak var collectionViewDeriverables: UICollectionView!
    private let roles = UserInformation.shared.roles ?? []
    var teckers: [DeliverableTeckers] = [] {
=======
class DeriverablesController: UIViewController {

    @IBOutlet weak var collectionViewDeriverables: UICollectionView!
    let nameCell = "DeriverablesCell"
    var deliverablesParent: [DeliverableParent] = [] {
>>>>>>> Deliverables display with full display
        didSet{
            self.collectionViewDeriverables.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

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
=======
        
        if UserInformation.shared.roles?.contains(Roles.Administrador.rawValue) ?? false {
            let nibCell = UINib(nibName: self.nameCell, bundle: nil)
            collectionViewDeriverables.register(nibCell, forCellWithReuseIdentifier: nameCell)
            DeliverableService.getDeliverableParent(success: { [weak self] deliverableArray in
                self?.deliverablesParent = deliverableArray
            })
        }
>>>>>>> Deliverables display with full display
    }
}


<<<<<<< HEAD
extension DeliverablesTekersController: UICollectionViewDelegate {

}

extension DeliverablesTekersController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teckers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeriverablesTeckersCell.nameCell, for: indexPath) as! DeriverablesTeckersCell
        
        DeriverablesTeckersCell.downloadImage(urlString: teckers[indexPath.row].imageUrl, completion: { data, error in
=======
extension DeriverablesController: UICollectionViewDelegate {

}

extension DeriverablesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deliverablesParent.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nameCell, for: indexPath) as! DeriverablesCell
        let mainRect = CGRect(x: 0, y: 0, width: cell.imageDeriverables.frame.width, height: cell.imageDeriverables.frame.height)
        
        DeriverablesCell.downloadImage(urlString: deliverablesParent[indexPath.row].imageUrl, completion: { data, error in
>>>>>>> Deliverables display with full display
            if let Error = error {
                let alertAction = Alert(title: "Error", massage: Error.localizedDescription)
                self.present(alertAction.showOK(), animated: true, completion: nil)
            }
            else if let Data = data {
<<<<<<< HEAD
                cell.commitInit(data: Data, name: self.teckers[indexPath.row].name)
            }
        })
        
=======
                DispatchQueue.main.async {
                    cell.imageDeriverables.image = UIImage(data: Data)
                    cell.imageDeriverables.layer.cornerRadius = cell.imageDeriverables.frame.height / 2
                    cell.imageDeriverables.layer.masksToBounds = true
                    cell.titleDeriverables.text = self.deliverablesParent[indexPath.row].name
                    DispatchQueue.main.async {
                        let render = UIGraphicsImageRenderer(size: mainRect.size)
                        cell.imageDeriverables.image = render.image(actions: { (context) in
                            context.fill(mainRect)
                            
                            cell.imageDeriverables.draw(mainRect)
                        })
                    }
                }
            }
            
            })

>>>>>>> Deliverables display with full display
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewDeriverables {
            let _ = collectionViewDeriverables.cellForItem(at: indexPath)
            
            
        }
    }
}
