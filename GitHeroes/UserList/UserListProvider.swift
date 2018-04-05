//
//  UserDetailProvider.swift
//  GitHeroes
//
//  Created by Reshma Unnikrishnan on 24.03.18.
//  Copyright © 2018 Reshma Unnikrishnan. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol UserListProviderType {
    func fetchData() -> Observable<AnyObject?>
}

final class UserListProvider: UserListProviderType {
   
    
    // MARK: Properties
    private var user : User
    
    //MARK: Initialisation
    
    init(user: User) {
        self.user = user
    }

    func fetchData() -> Observable<AnyObject?> {
        guard let username = user.userName else {
           return Observable.error(NSError(domain: "NoUserFound", code: 0, userInfo: nil))
        }
        return Observable.create {  observer in
            let provider = MoyaProvider<GitHubServices>()
            _ = provider.rx.request(.showUser(username: username)).subscribe {event in
                switch event {
                case let .success(response):
                    print(response)
                    observer.onNext(response)
                    observer.onCompleted()
                case let .error(error):
                    print(error)
                    observer.onNext(error as AnyObject)
                }
            }
            return Disposables.create()
            }
    }

    private func parseResponse(data: Any) -> Observable<[User]> {
        guard let json = data as? [[String: Any]],
        
            let users = self.parseUsers(from: json) else {
                let error = NSError(domain: "Parsing Error", code: 0, userInfo: nil)
                return  Observable.error(error)
        }
        return Observable.just(users)
    }

    private func parseUsers(from json: [[String: Any]]) -> [User]? {
        return nil
    }
}
