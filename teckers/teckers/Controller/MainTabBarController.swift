//
//  MainTabBarController.swift
//  teckers
//
//  Created by Maggie Mendez on 13/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//
import UIKit

class MainTabBarController: UITabBarController {

    let roles: [String] = UserDefaults.standard.array(forKey: TokenKeys.Roles.rawValue) as? [String] ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStoryboard = UIStoryboard(name: Storyboards.logedStoryboard.rawValue, bundle: Bundle.main)
        
        if !(roles.contains(Roles.Administrador.rawValue)) {
        }
        else if (roles.contains(Roles.Mentor.rawValue)) {
            if let viewMentor = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesParentMentor.rawValue) as? DeliverablesTeckersController {
                DeliverableService.getDeliverableMentor(completion: { [weak self] (deliverableArray, error) in
                    viewMentor.teckers = deliverableArray ?? []
                    if viewMentor.teckers.count == 1 {
                        if let viewTecker = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesTecker.rawValue) as? DeliverablesController {
                            self?.viewControllers?[1] = viewTecker
                        }
                    }
                    self?.viewControllers?[1] = viewMentor
                })
            }
        }
        else if (roles.contains(Roles.Parent.rawValue)) {
            if let viewParent = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesParentMentor.rawValue) as? DeliverablesTeckersController {
                DeliverableService.getDeliverableParent(completion: { [weak self] (deliverableArray, error) in
                    viewParent.teckers = deliverableArray ?? []
                    if viewParent.teckers.count == 1 {
                        if let viewTecker = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesTecker.rawValue) as? DeliverablesController {
                            self?.viewControllers?[1] = viewTecker
                        }
                    }
                    self?.viewControllers?[1] = viewParent
                })
            }
        }
        else if roles.contains(Roles.Tecker.rawValue) {
            if let viewTecker = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesTecker.rawValue) as? DeliverablesController {
                self.viewControllers?[1] = viewTecker
            }
        }
    }
}
