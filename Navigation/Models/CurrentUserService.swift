//
//  CurrentUserService.swift
//  Navigation
//
//  Created by mitr on 27.05.2022.
//

import Foundation

final class CurrentUserService: UserService {
    private let user: User
    
    init() {
        user = User(fullName: "admin", avatar: "avatar", status: "logined")
    }
    
    func userService(userName: String) -> User? {
        if userName == user.fullName {
            return user
        }
        return nil
    }
}
