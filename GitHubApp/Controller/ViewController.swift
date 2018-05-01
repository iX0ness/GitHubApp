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


class ViewController: UIViewController, UITextFieldDelegate {

    private struct Constants {
        static let repoListIdentifier = "repositorySegue"
    }

    var reposCount: Int?
    var login: String?

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!

    let alertPresenter: Presentr = {
        let presenter = Presentr(presentationType: .alert)
        presenter.transitionType = .flipHorizontal
        presenter.dismissTransitionType = .flipHorizontal

        return presenter
    }()

    // MARK: - VC lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTextField.delegate = self
        setupUI()


    }

    
    @IBAction func searchUserAction(_ sender: Any) {

            APIClient.login(login: loginTextField.text!, completion: { (user) in
                self.showAlertUser(user: user)
                guard let login = user?.login, let repos = user?.public_repos else {return}

                self.login = login
                self.reposCount = repos
                
            }, failure: { (error) -> Void? in
                self.showAlertResponseError(error: error)
            }) { (local_error) in
                self.showAlertError(error: local_error)
            }

    }
    

   private func setupUI() {

        // setUP view
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: colors)
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()

        // searchButton//
        searchButton.layer.cornerRadius = 3

    }

    // MARK: - Alerts setup

     private func showAlertUser(user: User?) {
        let alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .destructive, handler: nil)

            let okAction = AlertAction(title: "Show repos", style: .default, handler: { _ in
                self.performSegue(withIdentifier: Constants.repoListIdentifier, sender: self)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            alertController.titleText = "Success"
            if let login = user?.login {
                alertController.bodyText = "User \(login) was found"
            }

            return alertController
        }()

        self.customPresentViewController(self.alertPresenter, viewController: alertController, animated: true)
    }

     private func showAlertResponseError(error: ResponseError?) {
        let alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            alertController.titleText = "Failed"
            if let message = error?.message {
                alertController.bodyText = message
            }

            return alertController
        }()



        self.customPresentViewController(self.alertPresenter, viewController: alertController, animated: true)
    }

     private func showAlertError(error: Error?) {
        let alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            alertController.titleText = "Failed"
            alertController.bodyText = error?.localizedDescription

            return alertController
        }()

        self.customPresentViewController(self.alertPresenter, viewController: alertController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.repoListIdentifier {
            if let destination = segue.destination as? RepoListTableViewController {
                destination.login = self.login
                destination.reposCount = self.reposCount
                destination.navigationItem.title = self.login
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        return true
    }

}
