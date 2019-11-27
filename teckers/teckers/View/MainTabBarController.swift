//
//  MainTabBarController.swift
//  teckers
//
//  Created by Maggie Mendez on 13/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let roles = UserDefaults.standard.array(forKey: TokenKeys.roles.rawValue) ?? []
        for r in roles {
            let storyboard: UIStoryboard = UIStoryboard(name: Storyboards.logedStoryboard.rawValue, bundle: Bundle.main)
//            let navigation = UINavigationController()
            if let role = r as? String{
                switch(Roles(rawValue: role)){
                    case .Administrador:
                        if let programs = storyboard.instantiateViewController(withIdentifier: Views.ProgramBatchControllerID.rawValue) as? ProgramBatchController {
                            self.viewControllers?[1] = programs
                            return
                        }
                    case .Mentor:
                        if let chooseTecker = storyboard.instantiateViewController(withIdentifier: Views.DeliverableMentorID.rawValue) as? DeliverablesTeckersController {
                            chooseTecker.getTeckers()
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

extension MainTabBarController: UITabBarControllerDelegate{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Message"{
            if let navigation = navigationItem as? MainNavigationItem{
                navigation.setupMessages()
            }
        }
        else {
            navigationItem.rightBarButtonItems = []
        }
    }
}
