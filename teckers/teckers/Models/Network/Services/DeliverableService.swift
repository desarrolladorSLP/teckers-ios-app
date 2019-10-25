//
//  DeliverableService.swift
//  teckers
//
//  Created by Maggie Mendez on 15/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct DeliverableService {
    static func getDeliverableParent(success : @escaping (_ messages:[DeliverableParent]) -> Void){
        NetworkHandler.request(url: DeliverableRouter.getDeliverablesParent, onSucess: { (response) in
            do{
                if let data = response.data {
                    let deliverables = try JSONDecoder().decode([DeliverableParent].self, from: data)
                        success(deliverables)
                }
            } catch {
                print(error.localizedDescription)
            }
        }, onFailure: nil)
    }
}
