//
//  RepoTableViewCell.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 30.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import UIKit
import ChameleonFramework


class RepoTableViewCell: UITableViewCell {


    static let reuseIdentifier: String = "RepoTableViewCell"

    // MARK: -  Outlets
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoLang: UILabel!





    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: -  Cell's methods

    func configureCell(repoName: String, repoLang: String) {
        self.repoName.text = formatRepoName(repoName: repoName)
        self.repoLang.text = repoLang
        backgroundColor = UIColor.clear

    }

    private func formatRepoName(repoName: String?) -> String? {
        guard var repoName = repoName else {return nil}

        if repoName.count > 25 {
            let start = repoName.index(repoName.startIndex, offsetBy: 25)
            let end = repoName.index(repoName.startIndex, offsetBy: 25 + (repoName.count - 25))

            repoName.replaceSubrange(start..<end, with: "...")
        }
        return repoName
    }
    
}
