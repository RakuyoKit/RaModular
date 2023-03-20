//
//  ServiceNavigationProvider.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

///
public protocol ServiceNavigationProvider {    
    ///
    static var router: NavigationRouterURL { get }
    
    ///
    static var action: NavigationAction { get }
}
