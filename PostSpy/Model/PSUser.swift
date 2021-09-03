//
//  PSUser.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import Foundation

struct PSUser: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: PSAddress
    var company: PSCompany
}

struct PSAddress: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: PSCoordinates
}

struct PSCoordinates: Codable {
    var lat: String
    var lng: String
}

struct PSCompany: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
}
