//
//  PostSpyApp.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import SwiftUI

@main
struct PostSpyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(.postSpyPrimary)
    }
}
