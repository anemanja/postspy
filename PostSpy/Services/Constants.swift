//
//  Constants.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 3.9.21..
//

import Foundation
import SwiftUI

extension String {
    // MARK: User Defaults Keys
    public static let defaultsKeyLastRefreshIntervalSince1970 = "lastRefreshIntervalSince1970"
    
    // MARK: Local Cache Keys
    public static let cacheKeyPosts = "posts"
    public static let cacheKeyUsers = "users"
}

extension Double {
    public static let cacheLifetimeInterval: Double = 60 * 5
}

extension Color {
    public static let postSpyPrimary = Color(red: 0.1, green: 0.7, blue: 0.3)
    public static let postSpySecondary = Color(red: 0.7, green: 0.1, blue: 0.3)
    
    // MARK: Text Colors
    public static let postSpyTextPrimary = Color.postSpyPrimary
    public static let postSpyTextSecondary = Color.postSpySecondary
}
