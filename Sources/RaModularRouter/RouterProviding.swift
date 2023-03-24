//
//  RouterProviding.swift
//  RaModular
//
//  Created by Rakuyo on 2023/03/17.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

import RaModularCore

/// The service is declared as having a public view controller that can be accessed by other services.
///
/// You need to define a type in the service interface component that will follow this protocol.
///
/// For example, something like the following:
/// ```
/// import RaModular
///
/// public struct OrderService: RouterProviding {
///     public static func createRouterProvider() -> Any {
///         return OrderServiceProvider()
///     }
/// }
/// ```
public protocol RouterProviding {
    /// A placeholder to mask the real type.
    associatedtype RouterProviderMock = Any
    
    /// Used for creating a router provider.
    ///
    /// You should implement this method in the interface module of your service,
    /// returning an instance object that matches the `RouterProvider` type in your service module.
    ///
    /// NOTE: The service caller should not manually call this method.
    /// Please use the `open(with: mode: animated: completion:)` method to switch between view controllers.
    func createRouterProvider() -> RouterProviderMock
    
    /// A tool method that converts the return value of
    /// the `createRouterProvider()` method to a `RouterProvider` type.
    var routerProvider: RouterProvider { get }
    
    /// Open the view controller through the service object.
    ///
    /// For example:
    /// ```
    /// struct OrderService: RouterProviding {
    ///     static let shared = OrderService()
    ///     private init() { }
    ///
    ///     func createRouterProvider() -> Any {
    ///         return OrderServiceProvider()
    ///     }
    /// }
    ///
    /// extension OrderServiceProvider: RouterProvider {
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
    ///   - userInfo: Parameters that may be required during some routing processes.
    ///   - mode: The way to open the target controller. See `RouterMode` type for details.
    ///   - animated: Whether to use animation during switching. Support all cases of `RouterMode`.
    ///   - completion: The callback to be executed after the end of the animation. It may not work in some cases.
    func open(with userInfo: Parameters, mode: RouterMode?, animated: Bool?, completion: VoidClosure?)
}

// MARK: - Default

public extension RouterProviding {
    func open(
        with userInfo: Parameters = [:],
        mode: RouterMode? = nil,
        animated: Bool? = nil,
        completion: VoidClosure? = nil
    ) {
        guard let target = routerProvider.getRouterTarget(with: userInfo) else {
            print("⚠️ Invalid route providers, this navigation will be ignored.")
            return
        }
        
        // Enables automatic registration in some scenarios with the help of repeated registration.
        target.registerRouter()
        
        Router.open(target.router, with: userInfo, mode: mode, animated: animated, completion: completion)
    }
    
    var routerProvider: RouterProvider {
        guard let routerProvider = createRouterProvider() as? RouterProvider else {
            fatalError("You need to ensure that the object returned by `createRouterProvider()` is of type `\(RouterProvider.self)`! Please check your code.")
        }
        return routerProvider
    }
}
