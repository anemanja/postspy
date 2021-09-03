//
//  PostDetailsViewModel.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 3.9.21..
//

import Foundation

class PostDetailsViewModel: ViewModel {
    @Published private(set) var user: PSUser?
    @Published private(set) var postDeleted: Bool = false
    @Published private(set) var networkAlert: Bool = false
    @Published private(set) var networkErrorText: String = ""
    private let networkService: NetworkService = NetworkService()
    
    func loadUser(userId: Int, alert: @escaping () -> Void) {
        networkService.getUserWithId(String(userId))
        { [weak self] data in
            DispatchQueue.main.async {
                self?.user = data
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkErrorText = error ?? "Unknown error has occured."
                alert()
            }
        }
    }
    
    func deletePost(postId: Int, alert: @escaping () -> Void) {
        networkService.deletePostWithId(postId)
        { [weak self] in
            DispatchQueue.main.async {
                self?.postDeleted = true
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkErrorText = error
                alert()
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    init(mockFile: String) {
        super.init()
        user = load(mockFile) as PSUser
    }
}
