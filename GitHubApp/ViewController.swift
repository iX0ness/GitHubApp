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
import Presentr


class ViewController: UIViewController {



    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!

    let alertPresenter: Presentr = {
        let presenter = Presentr(presentationType: .alert)
        presenter.transitionType = .flipHorizontal
        presenter.dismissTransitionType = .flipHorizontal

        return presenter
    }()



    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()


    }

    
    @IBAction func searchUserAction(_ sender: Any) {

            APIClient.login(login: loginTextField.text!, completion: { (user) in
                self.showAlertUser(user: user)

            }, failure: { (error) -> Void? in
                self.showAlertResponseError(error: error)
            }) { (local_error) in
                self.showAlertError(error: local_error)
            }

    }
    

    func setupUI() {

        // setUP view
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: colors)
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()

        // searchButton//
        searchButton.layer.cornerRadius = 3

    }

    func showAlertUser(user: User?) {
        var alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .cancel, handler: nil)
            let okAction = AlertAction(title: "Show repos", style: .destructive, handler: { action in self.performSegue(withIdentifier: "repositorySegue", sender: self)})
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            alertController.titleText = "Success"
            if let login = user?.login {
                alertController.bodyText = "User \(login) was founded"
            }

            return alertController
        }()

        self.customPresentViewController(self.alertPresenter, viewController: alertController, animated: true)
    }

    func showAlertResponseError(error: ResponseError?) {
        var alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            alertController.titleText = "Failed"
            if let message = error?.message {
                alertController.bodyText = message
            }

            return alertController
        }()



        self.customPresentViewController(self.alertPresenter, viewController: alertController, animated: true)
    }

    func showAlertError(error: Error?) {
        var alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            alertController.titleText = "Failed"
            alertController.bodyText = error?.localizedDescription

            return alertController
        }()

        self.customPresentViewController(self.alertPresenter, viewController: alertController, animated: true)
    }

}








