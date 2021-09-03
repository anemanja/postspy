//
//  PSPostsViewModel.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import Foundation

class PostsViewModel: ObservableObject {
    @Published private(set) var posts: [PSPost] = []
    @Published private(set) var networkAlert: Bool = false
    @Published private(set) var networkErrorText: String = ""
    private let networkService: NetworkService = NetworkService()
    
    func reloadPosts() {
        networkService.get(endpoint: "posts", parameter: nil, forcedRefresh: false)
        { [weak self] data in
            if let postsResponse = try? JSONDecoder().decode([PSPost].self, from: data) {
                DispatchQueue.main.async {
                    self?.posts = postsResponse
                }
                return
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkAlert = true
                self?.networkErrorText = error.localizedDescription
            }
        }
    }
    
    init() {
        
    }
    
    init(mockFile: String) {
        posts = load(mockFile) as [PSPost]
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
