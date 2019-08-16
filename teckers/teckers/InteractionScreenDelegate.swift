//
//  navegationDelegate.swift
//  teckers
//
//  Created by Maggie Mendez on 8/14/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

protocol InteractionScreenDelegate {
    func goTo(with segueIdentifier : Segues )
    func error(message: String)
}
