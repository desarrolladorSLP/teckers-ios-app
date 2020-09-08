//
//  BatchService.swift
//  teckers
//
//  Created by Maggie Mendez on 15/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

struct BatchService {
    static func getBatches(by program: String, onSuccess success: @escaping ([Batch]) -> Void, onFailure failure: ((Error) -> Void)? ) {
        NetworkHandler.request(url: BatchRouter.getBatches(programId: program), onSucess: {(response) in
            do {
                if let data = response.data{
                    let batches = try JSONDecoder().decode([Batch].self, from: data)
                    success(batches)
                }
            } catch {
                failure?(error)
            }
        }, onFailure: failure)
    }
    static func getTeckers(by batch: String, onSuccess success: @escaping ([BatchTeckers]) -> Void, onFailure failure: ((Error) -> Void)? ) {
        NetworkHandler.request(url: BatchRouter.getTeckersByBatch(batchId: batch), onSucess: {(response) in
            do {
                if let data = response.data{
                    let batches = try JSONDecoder().decode([BatchTeckers].self, from: data)
                    success(batches)
                }
            } catch {
                failure?(error)
            }
        }, onFailure: failure)
    }
}
