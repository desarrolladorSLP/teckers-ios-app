//
//  Tecker.swift
//  teckers
//
//  Created by Maggie Mendez on 16/12/19.
//  Copyright © 2019 Teckers. All rights reserved.
//
import UIKit

protocol Tecker {
    var name: String { get }
    var teckerId: String { get}
    var imageURL: String? {get}
}
