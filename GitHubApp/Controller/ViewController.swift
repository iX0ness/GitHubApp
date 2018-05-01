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

    // MARK: -  Constants
    private struct Constants {
        static let repoListIdentifier = "repositorySegue"
    }

    // MARK: -  Properties

    var login: String?
    var repoCount: Int?

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
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
        recieveEvents()

    }

    deinit {
        stopRecieveEvents()
    }

    

    // MARK: -  Actions

    @IBAction func searchUserAction(_ sender: Any) {

            APIClient.login(login: loginTextField.text!, completion: { (user) in
                guard let login = user?.login else {return}
                guard let repoCount = user?.public_repos else {return}
                self.login = login
                self.repoCount = repoCount
                self.showAlertUser(user: user)

            }, failure: { (error) -> Void? in
                self.showAlertResponseError(error: error)
            }) { (local_error) in
                self.showAlertError(error: local_error)
            }

    }
    
    // MARK: -  View setup
   private func setupUI() {

        // view
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: colors)
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()

        // searchButton//
        searchButton.layer.cornerRadius = 15

    }

    // MARK: - Alerts setup

     private func showAlertUser(user: User?) {
        let alertController: AlertViewController = {

            let alertController = AlertViewController()
            let cancelAction = AlertAction(title: "Close", style: .destructive, handler: nil)
            let okAction = AlertAction(title: "Show repos", style: .default, handler: { _ in
                self.performSegue(withIdentifier: Constants.repoListIdentifier, sender: self)
            })

            if let login = user?.login {
                alertController.bodyText = "User \(login) was found"

                if self.repoCount == 0 {

                    alertController.bodyText?.append(", but doesn't have repositories")
                    alertController.addAction(cancelAction)
                } else {
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                }
            }

            alertController.titleText = "Success"
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

    // MARK: -  Passing data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.repoListIdentifier {
            if let destination = segue.destination as? RepoListTableViewController {
                destination.login = self.login
                destination.navigationItem.title = self.login
            }
        }
    }

    // MARK: -  Hidding keyboard

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        return true
    }

    // MARK: -  Keyboard events

    private func recieveEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    private func stopRecieveEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}


        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }

}
