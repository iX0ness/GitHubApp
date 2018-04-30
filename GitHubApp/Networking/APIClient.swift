//
//  APIClient.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 28.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import Foundation
import Alamofire


class APIClient {

    static func login(login: String, completion: @escaping (User?) -> Void, failure: @escaping (ResponseError?) -> Void?, localError: @escaping (Error?) -> Void) {
        self.performRequest(router: APIRouter.user(login: login), completion: completion, failure: failure, localError: localError)
    }

    static func getRepos(login: String, completion: @escaping ([RepoModel]?) -> Void, failure: @escaping (ResponseError?) -> Void?, localError: @escaping (Error?) -> Void) {
        self.performRequestWithArrayResponse(router: APIRouter.repos(login: login), completion: completion, failure: failure, localError: localError)
}

    private static func performRequest<T: Codable, E: Codable>(router: APIRouter, completion: @escaping (T?) -> Void, failure: @escaping (E?) -> Void?, localError: @escaping (Error?) -> Void) {
        Alamofire.request(router).response { (response) in
            switch response.response?.statusCode {
            case 200?:
                do {
                    if let result = response.data {
                        let user: T? = try JSONDecoder().decode(T.self, from: result)
                        completion(user)
                    }
                }
                catch {
                }
            case 404?:
                do {
                    let error: E? = try JSONDecoder().decode(E.self, from: response.data!)
                    failure(error)
                }catch {
                }
            default: localError(response.error)
            }
        }
    }

    private static func performRequestWithArrayResponse<T: Codable, E: Codable>(router: APIRouter, completion: @escaping ([T]?) -> Void, failure: @escaping (E?) -> Void?, localError: @escaping (Error?) -> Void) {
        Alamofire.request(router).response { (response) in
            switch response.response?.statusCode {
            case 200?:
                do {
                    if let result = response.data {
                        let user: [T] = try JSONDecoder().decode([T].self, from: result)
                        completion(user)
                    }
                }
                catch {
                }
            case 404?:
                do {
                    let error: E? = try JSONDecoder().decode(E.self, from: response.data!)
                    failure(error)
                }catch {
                }
            default: localError(response.error)
            }
        }
    }

}
