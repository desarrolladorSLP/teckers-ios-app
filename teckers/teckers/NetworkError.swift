//
//  NetworkError.swift
//  teckers
//
//  Created by Maggie Mendez on 10/9/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

 class NetworkError{
    static let instance = NetworkError()
    var delegate: InteractionScreenDelegate?
    private let messageErrors: [TypesNetworkErrors: (String, Int)]
    private let actionsBeforeAlert: [TypesNetworkErrors: () -> Void ]
    init() {
        messageErrors = [.badRequest : (TypesNetworkErrors.badRequest.rawValue, 0),
                         .unknow : (TypesNetworkErrors.unknow.rawValue, 0),
                         .unauthorized : (TypesNetworkErrors.unauthorized.rawValue, 0),
                         .forbidden: (TypesNetworkErrors.forbidden.rawValue, 0),
                         .pageNotFound : (TypesNetworkErrors.pageNotFound.rawValue, 0),
                         .requestTimeOut : (TypesNetworkErrors.requestTimeOut.rawValue, 1),
                         .noInternet: (TypesNetworkErrors.noInternet.rawValue, 0),
                         .noJSON: (TypesNetworkErrors.noJSON.rawValue, 0),
                         .internalServerError: (TypesNetworkErrors.internalServerError.rawValue, 0)]
        self.actionsBeforeAlert = [.unauthorized: {
            DispatchQueue.main.async{
                NetworkError.instance.delegate?.dismiss()
            }
        }]
    }

     func getInformation( for statusCode: NetworkAnswers) ->  (message: String, type: Int)?{
        switch statusCode.rawValue{
        case NetworkAnswers.requestTimeOutXcode.rawValue:
            return messageErrors[.requestTimeOut]
        case NetworkAnswers.ok.rawValue:
            return messageErrors[.noJSON]
        case NetworkAnswers.badRequest.rawValue:
            return messageErrors[.badRequest]
        case NetworkAnswers.unauthorized.rawValue:
            return messageErrors[.unauthorized]
        case NetworkAnswers.pageNotFound.rawValue:
            return messageErrors[.pageNotFound]
        case NetworkAnswers.internalServerError.rawValue:
            return messageErrors[.internalServerError]
        case NetworkAnswers.noInternet.rawValue:
            return messageErrors[.noInternet]
        default:
            return messageErrors[.unknow]
        }
    }
    func getActionBeforeAlert( for statusCode: NetworkAnswers) ->  (() -> Void)? {
        switch statusCode.rawValue{
        case NetworkAnswers.unauthorized.rawValue:
            return actionsBeforeAlert[.unauthorized]
        default:
            return nil
        }
    }

     func getAction(for statusCode: NetworkAnswers) -> () -> Void {
        let informationAnswer = getInformation(for: statusCode)

         return { [weak self] in
            guard let infoAlert = informationAnswer  else { return }
            if let action = self?.getActionBeforeAlert(for: statusCode) {
                action()
            }
            else{
                DispatchQueue.main.async {
                    NetworkError.instance.delegate?.error(message: infoAlert.message)
                }
            }
        }
    }
}
