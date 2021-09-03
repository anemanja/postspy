//
//  PSPost.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import Foundation

struct PSPost: Hashable, Codable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}

struct PSPostsResponse: Codable {
    var posts: [PSPost]
}

class PSPostWrapper: NSObject {
    
}
