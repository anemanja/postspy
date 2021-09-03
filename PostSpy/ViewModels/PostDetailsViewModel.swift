//
//  PostDetailsViewModel.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 3.9.21..
//

import Foundation

class PostDetailsViewModel: ObservableObject {
    @Published private(set) var user: PSUser?
    @Published private(set) var networkAlert: Bool = false
    @Published private(set) var networkErrorText: String = ""
    private let networkService: NetworkService = NetworkService()
    
    func loadUser(userId: Int) {
        networkService.get(endpoint: "users", parameter: String(userId), forcedRefresh: false)
        { [weak self] data in
            do {
                if let userResponse = try JSONDecoder().decode(PSUser?.self, from: data) {
                    DispatchQueue.main.async {
                        self?.user = userResponse
                    }
                    return
                }
            } catch {
                print(error)
            }
        } errorCallback: { [weak self] error in
            DispatchQueue.main.async {
                self?.networkAlert = true
                self?.networkErrorText = error.localizedDescription
            }
        }
    }
    
    func deletePost(postId: Int) {
        
    }
    
    init() {
        
    }
    
    init(mockFile: String) {
        user = load(mockFile) as PSUser
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
