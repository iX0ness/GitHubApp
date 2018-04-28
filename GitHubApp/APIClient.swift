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

        Alamofire.request(APIRouter.user(login: login)).response { (response) in

            switch response.response?.statusCode {
            case 200?:
                do {
                    if let result = response.data {
                        let user = try JSONDecoder().decode(User.self, from: result)
                        completion(user)
                    }
                }
                catch {
                }
            case 404?:
                do {
                    let error = try JSONDecoder().decode(ResponseError.self, from: response.data!)
                    failure(error)
                }catch {
                }
            default: localError(response.error)
            }
}
}

}
