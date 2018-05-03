//
//  RepoDetailViewController.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 30.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import UIKit
import ChameleonFramework

class RepoDetailViewController: UIViewController {

    // MARK: -  Properties

    var repo: RepoModel?

    // MARK: -  Outlets

    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - VC lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presentRepo()
    }


    // MARK: -  Get repo info
    private func presentRepo(){
        guard let repo = repo else {return}

        createdAtLabel.text = formatDate(date: repo.created_at) ?? ""
        updatedAtLabel.text = formatDate(date: repo.updated_at) ?? ""
        forksLabel.text = String(repo.forks ?? 0)
        descriptionLabel.text = repo.description

    }

    // MARK: -  View setup

    private func setupUI() {
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: colors)
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()
        createdAtLabel.sizeToFit()
        updatedAtLabel.sizeToFit()
        forksLabel.sizeToFit()
        descriptionLabel.sizeToFit()

    }


    //for testing purpose this function will be public after sucess result change to private

    // MARK: -  Formatting repo name
    // Formatting if repo name is too long

    func formatDate(date: String?) -> String? {
        guard let date = date else {return nil}

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let _date = dateFormatter.date(from: date) else {
            return nil
        }

        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "dd.MM.yy"
        let newDate = newDateFormatter.string(from: _date)

        return newDate
    }

}
