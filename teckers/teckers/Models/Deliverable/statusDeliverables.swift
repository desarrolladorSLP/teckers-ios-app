//
//  statusDeliverables.swift
//  teckersDeliverable
//
//  Created by Maggie Mendez on 10/8/19.
//  Copyright © 2019 Maggie Mendez. All rights reserved.
//

import UIKit

enum statusDeliverables: String, Decodable{
    case inProgress = "IN_PROGRESS"
    case toDo = "TO_DO"
    case readyForReview = "READY_FOR_REVIEW"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
    case blocked = "BLOCKED"
    case overdue = "OVERDUE"
    case none = "NONE"
}
