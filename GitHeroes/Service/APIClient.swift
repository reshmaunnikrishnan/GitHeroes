//
//  APIClient.swift
//  GitHeroes
//
//  Created by Reshma Unnikrishnan on 19.03.18.
//  Copyright © 2018 Reshma Unnikrishnan. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public enum GitHubServices {
    case allUsers
    case searchUsers(query: String, perPage: String, page: String )
    case showUser(username : String)
}

extension GitHubServices: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    public var path: String {
        switch self {
        case .allUsers:
            return "/users"
        case .searchUsers:
            return "/search/users"
        case .showUser(username: let name):
            return "/users/name"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        switch self {
        case .allUsers, .showUser :
            return "{\"id\": \"1942834\", \"login\": \"rechu88\",\"avatar_url\": \"https://avatars1.githubusercontent.com/u/1942834?v=4\"}".utf8Encoded
        case .searchUsers:
            return "".utf8Encoded
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .allUsers:
            return nil
        case .searchUsers(query: let query, perPage: let perPage, page: let page):
            return ["q": query, "per_page": perPage, "page": page]
        case .showUser(username: let name):
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }    
}

private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

