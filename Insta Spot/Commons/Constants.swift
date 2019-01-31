//
//  Constants.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/31/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import Foundation

struct Constants {
    struct UnsplashSettings {
        static let host = "unsplash.com"
        static let callbackURLScheme = "papr://"
        static let clientID = UnsplashSecrets.clientID
        static let clientSecret = UnsplashSecrets.clientSecret
        static let authorizeURL = "https://unsplash.com/oauth/authorize"
        static let tokenURL = "https://unsplash.com/oauth/token"
        static let redirectURL = "papr://unsplash"
        
        struct UnsplashSecrets {
            
            static let clientSecret = "873c092d427ae048e7044a1491a37e3027c0a84fb4f97ed9897bb62137ace6f6"
            static let clientID = "358bd86f2c14fc4a7fa0aab41571241aa6a0ffbef4d3109d290ffa13de9e794c"
//            static let clientID = UnsplashSecrets.environmentVariable(named: "UNSPLASH_CLIENT_ID") ?? ""
//            static let clientSecret = UnsplashSecrets.environmentVariable(named: "UNSPLASH_CLIENT_SECRET") ?? ""
//
//            private static func environmentVariable(named: String) -> String? {
//                guard let infoDictionary = Bundle.main.infoDictionary, let value = infoDictionary[named] as? String else {
//                    print("‼️ Missing Environment Variable: '\(named)'")
//                    return nil
//                }
//                return value
//            }
        }
    }
}
