//
//  ServiceRouterProvider.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

public protocol ServiceRouterProvider {
    
    static var router: ServiceRouter { get }
    
    static var factory: Router.Factory { get }
}
