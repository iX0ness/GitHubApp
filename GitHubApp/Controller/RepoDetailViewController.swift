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

    var login: String?
    var repoName: String?
    var createdAt: String?
    var updatedAt: String?
    var descriptionRep: String?
    var forks: Int?
    var repo: RepoModel?

    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presentRepo()
    }

    
    private func presentRepo(){
        guard let repo = repo else {return}

        createdAtLabel.text = formatDate(date: repo.created_at) ?? ""
        updatedAtLabel.text = formatDate(date: repo.updated_at) ?? ""
        forksLabel.text = String(repo.forks ?? 0)
        descriptionLabel.text = repo.description

    }

    private func setupUI() {
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: colors)
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()
        createdAtLabel.sizeToFit()
        updatedAtLabel.sizeToFit()
        forksLabel.sizeToFit()
        descriptionLabel.sizeToFit()

    }

    private func formatDate(date: String?) -> String? {
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
