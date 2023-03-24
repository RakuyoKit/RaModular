//
//  RouterPredefinedKey.swift
//  RaModularRouter
//
//  Created by Rakuyo on 2023/03/24.
//  Copyright © 2023 Rakuyo. All rights reserved.
//

import Foundation

public extension Router {
    /// Some key that may be used in the process of switching view controllers.
    public enum PredefinedKey {
        /// If you want to define the way to open a view controller in the URL, please use this key.
        /// 
        /// For details, please refer to `RouterMode.Identifier`.
        public static let modeType = "rmd_mode_type"
        
        /// If you want to define whether to use animation when opening a view controller in the URL, please use this key.
        ///
        /// Anything non-zero or non-false will be treated as `Swift.Bool.true`
        public static let animation = "rmd_animation"
    }
}
