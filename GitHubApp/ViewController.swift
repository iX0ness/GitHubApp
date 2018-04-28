//
//  ViewController.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 24.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import UIKit
import Alamofire




class ViewController: UIViewController {

    struct Constants {
        static let baseURL = "https://api.github.com/users/iX0ness"

    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        Alamofire.request(Constants.baseURL).responseJSON { (response) in
//
//            if let result = response.result.value as? [String: String] {
//                if let message = result["message"] {
//                    print(message)
//                }
//            } else {
//                let result = response.data
//                do {
//
//                    let user = try JSONDecoder().decode(User.self, from: result!)
//                    print(user)


        APIClient.login(login: "sdfdsgdsgfdsg", completion: { (user) in
            print(user?.name)
        }, failure: { (error) -> Void? in
            print(error?.message)
        }) { (local_error) in
            print(local_error?.localizedDescription)
        }

    }




}
