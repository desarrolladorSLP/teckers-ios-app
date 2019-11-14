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
//        self.toolbarItems?.index(after: 1)
//        for vc in self.viewControllers ?? []{
//            if vc is DeliverablesController {
//
//            }
//        }
        let roles = UserDefaults.standard.array(forKey: TokenKeys.roles.rawValue) ?? []
        for r in roles {
            if let role = r as? String, role == "ROLE_ADMINISTRATOR"{
                let storyboard = UIStoryboard(name: Storyboards.logedStoryboard.rawValue, bundle: Bundle.main)
                if let home = storyboard.instantiateViewController(withIdentifier: Views.DeliverablesID.rawValue) as? DeliverablesController {
                    self.viewControllers?[1] = home
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
