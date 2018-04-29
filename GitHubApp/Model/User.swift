//
//  User.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 28.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import Foundation

struct ResponseError: Codable {
    var message: String?

    private enum CodingKeys: String, CodingKey {
        case message
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct User: Codable {
    var login: String?
    var name: String?
    var company: String?
    var location: String?
    var public_repos: Int?

    private enum CodingKeys: String, CodingKey {
        case login
        case name
        case company
        case location
        case public_repos
    }

     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        public_repos = try values.decodeIfPresent(Int.self, forKey: .public_repos)
    }
}
