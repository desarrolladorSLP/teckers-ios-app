//
//  DeliverableService.swift
//  teckers
//
//  Created by Maggie Mendez on 15/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct DeliverableService {
    static func getDeliverableTeckers(roles: [String], completion: @escaping (_ messages: [DeliverableTeckers]?, _ error: Error?) -> Void) {
        
        if (roles.contains(Roles.Parent.rawValue)) {
            NetworkHandler.request(url: DeliverableRouter.getDeliverablesParent, onSucess: { (response) in
                do {
                    if let data = response.data {
                        let deliverables = try JSONDecoder().decode([DeliverableTeckers].self, from: data)
                            completion(deliverables, nil)
                    }
                }
                catch {
                    completion(nil, error)
                }
            }, onFailure: nil)
        }
        else if (roles.contains(Roles.Mentor.rawValue) ) {
            NetworkHandler.request(url: DeliverableRouter.getDeliverablesMentor, onSucess: { (response) in
                do{
                    if let data = response.data {
                        let deliverables = try JSONDecoder().decode([DeliverableTeckers].self, from: data)
                        completion(deliverables, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            }, onFailure: nil)
        }
    }
}
