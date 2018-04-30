//
//  RepoListTableViewController.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 29.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import UIKit

class RepoListTableViewController: UITableViewController {

    private struct Constants {
        static let repoTableViewCellNib = "RepoTableViewCell"
        static let repoTableViewCell = "RepoTableViewCell"
        static let repoDetailSegue = "repoDetailSegue"
    }
    @IBOutlet var reposTableView: UITableView!
    
    var login: String?
    var reposCount: Int?

    var repoModelArray: [RepoModel]? {
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.performRequest()
    }

    private func performRequest() {
        guard let login = login else {
            return
        }

        APIClient.getRepos(login: login, completion: { (repoArray) in
            self.repoModelArray = repoArray
        }, failure: { (error_model) -> Void? in
            print("PIZDA")
        }) { (local_error) in
            print("ZALUPA")
        }
    }

    private func configureTableView() {
        self.tableView.register(UINib(nibName: Constants.repoTableViewCellNib, bundle: nil), forCellReuseIdentifier: Constants.repoTableViewCell)
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoModelArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repoCell = self.tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? RepoTableViewCell, let repoModel = self.repoModelArray else {
            return UITableViewCell()
        }

        let repo = repoModel[indexPath.row]
        repoCell.configureCell(repoName: repo.name ?? "", repoLang: repo.language ?? "")

        return repoCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.repoDetailSegue, sender: self)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?, indexPath: IndexPath) {
        if segue.identifier == Constants.repoDetailSegue {
            if let destination = segue.destination as? RepoDetailViewController {
                
            }
        }
    }

    


}
