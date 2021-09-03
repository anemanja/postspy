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
    
    func get(endpoint: String, parameter: String?, forcedRefresh: Bool, callback: @escaping (_ data: Data) -> Void, errorCallback: @escaping (_ error: Error) -> Void) {

        guard let url = URL(string: apiAddress + "/" + endpoint + "/" + (parameter ?? "")) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: currentCachePolicy(forcedRefresh: forcedRefresh))
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
    
    private let USER_DEFAULTS_KEY_lastRefreshDate: String = "lastRefreshDate"
    private func currentCachePolicy(forcedRefresh: Bool) -> URLRequest.CachePolicy {
        if (forcedRefresh) {
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: USER_DEFAULTS_KEY_lastRefreshDate)
            return .reloadIgnoringLocalCacheData
        }
        
        let lastRefreshDate = UserDefaults.standard.double(forKey: USER_DEFAULTS_KEY_lastRefreshDate)
        if (lastRefreshDate + 5 * 60 < Date().timeIntervalSince1970) {
            return .returnCacheDataElseLoad
            
        } else {
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: USER_DEFAULTS_KEY_lastRefreshDate)
            return .reloadIgnoringLocalCacheData
        }
    }
}
