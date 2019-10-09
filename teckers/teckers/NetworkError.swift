//
//  NetworkError.swift
//  
//
//  Created by Maggie Mendez on 10/9/19.
//

import Foundation
import UIKit

 class NetworkError{
    static let instance = NetworkError()
    static var delegate: InteractionScreenDelegate?
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
//                NetworkError.delegate?.dismiss()
            }
        }]
    }

     func getInformation( for statusCode: Int) ->  (message: String, type: Int)?{
        switch statusCode{
        case ..<0:
            return messageErrors[.requestTimeOut]
        case 200:
            return messageErrors[.noJSON]
        case 400:
            return messageErrors[.badRequest]
        case 401:
            return messageErrors[.unauthorized]
        case 404:
            return messageErrors[.pageNotFound]
        case 400..<500:
            return messageErrors[.unknow]
        case 500..<600:
            return messageErrors[.internalServerError]
        case 600:
            return messageErrors[.noInternet]
        default:
            return messageErrors[.unknow]
        }
    }
    func getActionBeforeAlert( for statusCode: Int) ->  (() -> Void)? {
        switch statusCode{
        case 401:
            return actionsBeforeAlert[.unauthorized]
        default:
            return nil
        }
    }

     func getAction(for statusCode: Int) -> () -> Void {
        let informationAnswer = getInformation(for: statusCode)

         return { [weak self] in
            guard let infoAlert = informationAnswer else { return }
            if let action = self?.getActionBeforeAlert(for: statusCode) {
                action()
            }
            else{
                DispatchQueue.main.async {
                    NetworkError.delegate?.error(message: infoAlert.message)
                }
            }
        }
    }
}
