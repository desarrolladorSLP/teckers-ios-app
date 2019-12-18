//
//  DeliverableService.swift
//  teckers
//
//  Created by Maggie Mendez on 15/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct DeliverableService {
    static func getDeliverable(completion : @escaping (_ messages:[Deliverable]?, Error?) -> Void) {
        NetworkHandler.request(url: DeliverableRouter.getDeliverables, onSucess: { (response) in
            do {
                if let data = response.data {
                    let deliverables = try JSONDecoder().decode([Deliverable].self, from: data)
                    completion(deliverables, nil)
                }
            }
            catch {
                completion(nil, error)
            }
        }, onFailure: nil)
    }
            
    static func getDeliverableParent(completion : @escaping (_ messages:[DeliverableTeckers]?, Error?) -> Void) {
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
    
    static func getDeliverableMentor(completion : @escaping (_ messages:[DeliverableTeckers]?, Error?) -> Void) {
        NetworkHandler.request(url: DeliverableRouter.getDeliverablesMentor, onSucess: { (response) in
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
                               
    static func getOneDeliverable(for id: String, onSuccess success: @escaping (_ result: Deliverable) -> Void, onFailure: ((Error)->Void)?){
        NetworkHandler.request(url: DeliverableRouter.getOneDeliverableWith(id), onSucess: { (response) in
            do{
                if let data = response.data{
                    let deliverable = try JSONDecoder().decode(Deliverable.self, from: data)
                    success(deliverable)
                }
            }
            catch{
              print(error.localizedDescription)
            }
        }, onFailure: nil)
    }
    
    static func getDeliverableId(id: String, success : @escaping (_ messages:[Deliverable]) -> Void, onFailure failure: ((Error)->Void)?) {
        NetworkHandler.request(url: DeliverableRouter.getDeliverablesId(teckerId: id), onSucess: { (response) in
            do{
                if let data = response.data {
                    let deliverables = try JSONDecoder().decode([Deliverable].self, from: data)
                    success(deliverables)
                }
            } catch {
                failure?(error)
            }
        }, onFailure: failure)
    }

    static func postDeliverable(for id: String, text: String, onSuccess success: @escaping () -> Void, onFailure failure: () -> Void) {
        NetworkHandler.request(url: DeliverableRouter.postDeliverable(id: id, text: text), onSucess: { (response) in
            success()
        }, onFailure: nil)
    }
}
