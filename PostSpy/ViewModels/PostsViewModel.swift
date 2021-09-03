//
//  PSPostsViewModel.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import Foundation

class PostsViewModel: ViewModel {
    @Published private(set) var posts: [PSPost] = []
    @Published private(set) var networkErrorText: String = ""
    private let networkService: NetworkService = NetworkService()
    
    func reloadPosts(forcedRefresh: Bool = false, alert: @escaping () -> Void) {
        networkService.getPosts (forcedRefresh: forcedRefresh)
        { [weak self] data in
            DispatchQueue.main.async {
                self?.posts = data
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkErrorText = error ?? "Unknown error has occured."
                alert()
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
