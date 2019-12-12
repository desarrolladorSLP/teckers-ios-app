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
        let roles = UserDefaults.standard.array(forKey: TokenKeys.Roles.rawValue) ?? []
        let storyboard: UIStoryboard = UIStoryboard(name: Storyboards.logedStoryboard.rawValue, bundle: Bundle.main)
        if let role = roles[0] as? String{
            switch(Roles(rawValue: role)){
                case .Administrador:
                    if let programs = storyboard.instantiateViewController(withIdentifier: Views.ProgramBatchControllerID.rawValue) as? UIViewController {
                        self.viewControllers?[1] = programs
                        return
                    }
                case .Parent:
                    if let viewParent = storyboard.instantiateViewController(withIdentifier: Views.DeliverablesParentMentor.rawValue) as? DeliverablesTeckersController {
                        DeliverableService.getDeliverableParent(completion: { [weak self] (deliverableArray, error) in
                            viewParent.teckers = deliverableArray ?? []
                            if viewParent.teckers.count == 1 {
                                if let viewTecker = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesTecker.rawValue) as? DeliverablesController {
                                    self?.viewControllers?[1] = viewTecker
                                }
                            }
                            self?.viewControllers?[1] = viewParent
                            return
                        })
                    }
                case .Mentor:
                    if let viewMentor = storyboard.instantiateViewController(withIdentifier: Views.DeliverablesParentMentor.rawValue) as? DeliverablesTeckersController {
                        DeliverableService.getDeliverableMentor(completion: { [weak self] (deliverableArray, error) in
                            viewMentor.teckers = deliverableArray ?? []
                            if viewMentor.teckers.count == 1 {
                                if let viewTecker = mainStoryboard.instantiateViewController(withIdentifier: Views.DeliverablesTecker.rawValue) as? DeliverablesController {
                                    self?.viewControllers?[1] = viewTecker
                                }
                            }
                            self?.viewControllers?[1] = viewMentor
                            return
                        })
                    }
                case .Tecker:
                    if let deliverable = storyboard.instantiateViewController(withIdentifier: Views.DeliverablesID.rawValue) as? DeliverablesController {
                        self.viewControllers?[1] = deliverable
                    }
                default:
                    break
            }
        }
    }
}
