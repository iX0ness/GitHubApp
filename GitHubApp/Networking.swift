//
//  Networking.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 28.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import Foundation

class Networking {

    var baseURL = "https://api.github.com/users/"
    let user: String

    init(user: String) {
        self.user = user
        baseURL.append(user)
    }

    func getUser() {
        
    }




}
