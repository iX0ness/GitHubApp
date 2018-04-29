//
//  ViewController.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 24.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import UIKit
import Alamofire
import ChameleonFramework





class ViewController: UIViewController {

//    struct Constants {
//        static let baseURL = "https://api.github.com/users/iX0ness"
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()



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


        APIClient.login(login: "iX0ness", completion: { (user) in
            print(user?.name)
        }, failure: { (error) -> Void? in
            print(error?.message)
        }) { (local_error) in
            print(local_error?.localizedDescription)
        }

    }


    func setupUI() {

        // setUP view
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: colors)
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()
    }



}

