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

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoLang: UILabel!

    func configureCell(repoName: String, repoLang: String) {
        self.repoName.text = repoName
        self.repoLang.text = repoLang
        backgroundColor = UIColor.clear

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
