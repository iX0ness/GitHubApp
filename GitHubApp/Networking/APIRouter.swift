//
//  APIRouter.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 28.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {

    case user(login: String)
    case repos(login: String)

    private var method: HTTPMethod {
        switch self {
        case .user, .repos:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .user(let login):
            return "/users/\(login)"
        case .repos(let login):
            return "/users/\(login)/repos"


        }
    }

    private var parameters: Parameters? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest

    }
}
