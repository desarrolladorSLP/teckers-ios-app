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
        for r in roles {
            let storyboard: UIStoryboard = UIStoryboard(name: Storyboards.logedStoryboard.rawValue, bundle: Bundle.main)
//            let navigation = UINavigationController()
            if let role = r as? String{
                switch(Roles(rawValue: role)){
                    case .Administrador:
//                                if let programs = storyboard.instantiateViewController(withIdentifier: Views.ProgramBatchControllerID.rawValue) as? ProgramBatchController {
//                                    self.viewControllers?[1] = programs
                            return
//                                }
                    case .Mentor:
                        if let chooseTecker = storyboard.instantiateViewController(withIdentifier: Views.DeliverablesParentMentor.rawValue) as? DeliverablesTeckersController {
//                                    chooseTecker.getTeckers()
                            self.viewControllers?[1] = chooseTecker
                            return
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
}
