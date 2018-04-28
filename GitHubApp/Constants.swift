//
//  Constants.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 28.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import Foundation

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.github.com"
    }

    struct APIParameterKey {
        static let login = "login"

    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
