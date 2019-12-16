//
//  Batch.swift
//  teckers
//
//  Created by Maggie Mendez on 15/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct Batch: Decodable {
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let notes: String
}
