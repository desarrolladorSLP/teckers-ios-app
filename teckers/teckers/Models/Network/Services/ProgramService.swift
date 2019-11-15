//
//  ProgramService.swift
//  teckers
//
//  Created by Maggie Mendez on 14/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class ProgramService{
    static func getPrograms(onSuccess success: @escaping ([Program]) -> Void, onFailure failure: ((Error) -> Void)?){
        NetworkHandler.request(url: ProgramRouter.getPrograms , onSucess: { (response) in
            do {
                if let data = response.data{
                    let programs = try JSONDecoder().decode([Program].self, from: data)
                    success(programs)
                }
            } catch {
                failure?(error)
            }
        }, onFailure: failure)
    }
}
