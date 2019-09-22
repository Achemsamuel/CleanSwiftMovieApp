//
//  UserDefault_Extension.swift
//  MovieApp
//
//  Created by Achem Samuel on 9/21/19.
//

import Foundation

extension UserDefaults {
    
   private enum UserDefaultKeys : String {
        case apiKey
    }
    
    var apiKey : String? {
        get {
            return string(forKey: UserDefaultKeys.apiKey.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultKeys.apiKey.rawValue)
        }
    }
}
