//
//  User.swift
//  GitHeroes
//
//  Created by Reshma Unnikrishnan on 24.03.18.
//  Copyright © 2018 Reshma Unnikrishnan. All rights reserved.
//

import Foundation
import JASON

private extension JSONKeys {
    static let id =  JSONKey<Int>("id")
    static let name = JSONKey<String>("name")
    static let avatarUrl = JSONKey<String>("avatarUrl")
    static let url  = JSONKey<String>("url")
    static let createdAt = JSONKey<Date>("createdAt")
    static let email =  JSONKey<String>("email")
    static let company = JSONKey<String>("company")
    static let location = JSONKey<String>("location")
}

struct User {
    var identifier: Int!
    var userName: String!
    var avatarUrl: String?
    var url: String!
    var createdAt:Date!
    var email: String?
    var company: String?
    var location: String?
    
    init(_ json: JSON) throws {
        identifier = json[.id]
        userName = json[.name]
        avatarUrl = json[.avatarUrl]
        url = json[.url]
        email = json[.email]
        company = json[.company]
        location = json[.location]
    }

}
