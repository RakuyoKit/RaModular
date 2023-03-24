//
//  ServiceNavigationProviding.swift
//  RaServices
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaServicesCore

/// Declares that the service contains view controllers that can be accessed externally.
///
/// Let's take a concrete example to see how to use this protocol.
///
/// ```swift
/// import RaServices
///
/// public struct OrderService: ServiceNavigationProviding {
///     public static func createNavigationProvider() -> Any {
///         return OrderServiceProvider()
///     }
/// }
/// ```
public protocol ServiceNavigationProviding {
    /// The real provider of the service.
    /// The type masked by the `NavigationProviderMock`. 
    typealias NavigationProvider = ServiceNavigationProvider
    
    /// A placeholder to mask the real type.
    associatedtype NavigationProviderMock = Any
    
    /// Used for creating a navigation provider.
    ///
    /// You should implement this method in the interface module of your service/component,
    /// returning an instance object that matches the `NavigationProvider` type in your service/component module.
    ///
    /// NOTE: The service/component caller should not manually call this method.
    /// Please use the `open(with:, mode:, animated:, completion:)` method to switch between view controllers.
    func createNavigationProvider() -> NavigationProviderMock
    
    /// A tool method that converts the return value of
    /// the `createNavigationProvider` method to a `NavigationProvider` type.
    var routerProvider: NavigationProvider { get }
    
    /// Open the view controller through the service object.
    ///
    /// For example:
    /// ```swift
    /// struct OrderService: ServiceNavigationProviding {
    ///     static let shared = OrderService()
    ///     private init() { }
    ///
    ///     func createNavigationProvider() -> Any {
    ///         return OrderServiceProvider()
    ///     }
    /// }
    ///
    /// extension OrderServiceProvider: ServiceNavigationProvider {
    ///     func getRouterTarget(with userInfo: Parameters) -> NavigableViewControllerType? {
    ///         return OrderListViewController.self
    ///     }
    /// }
    ///
    /// OrderService.shared.open(mode: .show(), animated: true) {
    ///     print("after viewDidAppear")
    /// }
    /// ```
    ///
    /// When switching between view controllers via this method,
    /// there is no need to perform a registration operation.
    /// Automatic registration is performed in the default implementation.
    ///
    /// We do not recommend that you over-rely on this logic and ignore manual registration.
    /// For example, you might consider "The first time controller A appears,
    /// it must be displayed through this method, and later it may be displayed through the url,
    /// so there is no need to register controller A manually".
    /// However, this behavior is risky and should be treated with care.
    ///
    /// - Parameters:
    ///   - userInfo: Some parameters to be passed by the initiator to the target controller.
    ///   - mode: The way to open the target controller. See `NavigationMode` type for details.
    ///   - animated: Whether to use animation during switching. Support all cases of `NavigationMode`.
    ///   - completion: The callback to be executed after the end of the animation. Support all cases of `NavigationMode`.
    func open(with userInfo: Parameters, mode: NavigationMode?, animated: Bool?, completion: VoidClosure?)
}

// MARK: - Default

public extension ServiceNavigationProviding {
    func open(
        with userInfo: Parameters = [:],
        mode: NavigationMode? = nil,
        animated: Bool? = nil,
        completion: VoidClosure? = nil
    ) {
        guard let target = routerProvider.getRouterTarget(with: userInfo) else {
            print("⚠️ Invalid route providers, this navigation will be ignored.")
            return
        }
        
        // Enables automatic registration in some scenarios with the help of repeated registration.
        target.registerRouter()
        
        Navigation.open(target.router, with: userInfo, mode: mode, animated: animated, completion: completion)
    }
    
    var routerProvider: NavigationProvider {
        guard let routerProvider = createNavigationProvider() as? NavigationProvider else {
            fatalError("You need to ensure that the object returned by `createNavigationProvider()` is of type `\(NavigationProvider.self)`! Please check your code.")
        }
        return routerProvider
    }
}
