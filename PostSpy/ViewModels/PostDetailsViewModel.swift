//
//  PostDetailsViewModel.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 3.9.21..
//

import Foundation

class PostDetailsViewModel: ViewModel {
    @Published private(set) var user: PSUser?
    @Published private(set) var networkAlert: Bool = false
    @Published private(set) var networkErrorText: String = ""
    private let networkService: NetworkService = NetworkService()
    
    func loadUser(userId: Int) {
        networkService.getUserWithId(String(userId))
        { [weak self] data in
            DispatchQueue.main.async {
                self?.user = data
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkAlert = true
                self?.networkErrorText = error ?? "Unknown error has occured."
            }
        }
    }
    
    func deletePost(postId: Int) {
        
    }
    
    override init() {
        super.init()
    }
    
    init(mockFile: String) {
        super.init()
        user = load(mockFile) as PSUser
    }
}
