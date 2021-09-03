//
//  Network.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import Foundation

class NetworkService {
    let apiAddress: String = "https://jsonplaceholder.typicode.com"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func get(endpoint: String, parameter: String?, callback: @escaping (_ data: Data) -> Void, errorCallback: @escaping (_ error: Error) -> Void) {

        guard let url = URL(string: apiAddress + "/" + endpoint + "/" + (parameter ?? "")) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        URLSession.shared.dataTask(with: request) { d, r, e in
            guard let httpResponse = r as? HTTPURLResponse else { return }
            if (httpResponse.statusCode == 200) {
                if (d != nil) {
                    callback(d!)
                }
            } else {
                if (e != nil) {
                    errorCallback(e!)
                }
            }
        }.resume()
    }
    
    func getPosts(forcedRefresh: Bool = false, callback: @escaping (_ data: [PSPost]) -> Void, errorCallback: @escaping (_ error: String?) -> Void) {
        if (forcedRefresh || UserDefaults.standard.value(forKey: .cacheKeyPosts) == nil || Date().timeIntervalSince1970 - UserDefaults.standard.double(forKey: .defaultsKeyLastRefreshIntervalSince1970) > .cacheLifetimeInterval) {
            get(endpoint: "posts", parameter: nil)
            { data in
                if let postsResponse = try? JSONDecoder().decode([PSPost].self, from: data) {
                    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(postsResponse), forKey: .cacheKeyPosts)
                    UserDefaults.standard.setValue(Date().timeIntervalSince1970, forKey: .defaultsKeyLastRefreshIntervalSince1970)
                    callback(postsResponse)
                    return
                }
            } errorCallback: { error in
                errorCallback(error.localizedDescription)
            }
        } else {
            if let data = UserDefaults.standard.value(forKey: .cacheKeyPosts) as? Data {
                let postsResponse = try? PropertyListDecoder().decode([PSPost].self, from: data)
                callback(postsResponse ?? [])
            } else {
                errorCallback("Error reading posts from cache.")
            }
        }
    }
    
    func deletePostWithId(_ postId: Int, callback: @escaping () -> Void, errorCallback: @escaping (_ error: String) -> Void) {
        if let data = UserDefaults.standard.value(forKey: .cacheKeyPosts) as? Data {
            do {
                let posts = try PropertyListDecoder().decode([PSPost].self, from: data)
                var newPosts: [PSPost] = []
                for post in posts {
                    if (post.id != postId) {
                        newPosts.append(post)
                    }
                }
                UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newPosts), forKey: .cacheKeyPosts)
                callback()
            } catch {
                errorCallback("Error reading posts from cache.")
            }
        } else {
            errorCallback("Error reading posts from cache.")
        }
    }
    
    func getUserWithId(_ userId: String, forcedRefresh: Bool = false, callback: @escaping (_ data: PSUser) -> Void, errorCallback: @escaping (_ error: String?) -> Void) {
        if (forcedRefresh || UserDefaults.standard.value(forKey: .cacheKeyUsers) == nil || Date().timeIntervalSince1970 - UserDefaults.standard.double(forKey: .defaultsKeyLastRefreshIntervalSince1970) > .cacheLifetimeInterval) {
            get(endpoint: "users/" + userId, parameter: nil)
            { data in
                if let userResponse = try? JSONDecoder().decode(PSUser.self, from: data) {
                    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(userResponse), forKey: .cacheKeyUsers + userId)
                    callback(userResponse)
                    return
                }
            } errorCallback: { error in
                errorCallback(error.localizedDescription)
            }
        } else {
            if let data = UserDefaults.standard.value(forKey: .cacheKeyUsers) as? Data {
                do {
                    let userResponse = try PropertyListDecoder().decode(PSUser.self, from: data)
                    callback(userResponse)
                } catch {
                    errorCallback(("Error reading user with id = " + userId + " from cache."))
                }
            } else {
                errorCallback("Error reading user with id = " + userId + " from cache.")
            }
        }
    }
}
