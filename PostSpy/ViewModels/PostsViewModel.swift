//
//  PSPostsViewModel.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import Foundation

class PostsViewModel: ViewModel {
    @Published private(set) var posts: [PSPost] = []
    @Published private(set) var networkAlert: Bool = false
    @Published private(set) var networkErrorText: String = ""
    private let networkService: NetworkService = NetworkService()
    
    func reloadPosts() {
        networkService.getPosts
        { [weak self] data in
            DispatchQueue.main.async {
                self?.posts = data
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkAlert = true
                self?.networkErrorText = error ?? "Unknown error has occured."
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    init(mockFile: String) {
        super.init()
        posts = load(mockFile) as [PSPost]
    }
}
