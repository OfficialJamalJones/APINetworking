//
//  UserPrefs.swift
//  APINetworking
//
//  Created by Consultant on 12/29/22.
//

import Foundation

// Access Shared Defaults Object
let userDefaults = UserDefaults.standard

// Read Boolean
let value = userDefaults.object(forKey: "myKey") as? Bool ?? false

// Write/Set Value
//userDefaults.set(true, forKey: "myKey")
