//
//  RepoListTableViewController.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 29.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import UIKit
import ChameleonFramework

class RepoListTableViewController: UITableViewController {

    // MARK: -  Constants

    private struct Constants {
        static let repoDetailSegue = "repoDetailSegue"
    }

    // MARK: -  Outlets

    @IBOutlet var reposTableView: UITableView!
    
    var login: String?
    var repo: RepoModel?

    var repoModelArray: [RepoModel]? {
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.setupUI()
        self.performRequest()
    }


    private func performRequest() {
        guard let login = login else {
            return
        }

        APIClient.getRepos(login: login, completion: { (repoArray) in
            self.repoModelArray = repoArray

        }, failure: { (error_model) -> Void? in
            print(error_model.debugDescription)
        }) { (local_error) in
            print(local_error?.localizedDescription)
        }
    }

    private func configureTableView() {
        self.tableView.register(UINib(nibName: RepoTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: RepoTableViewCell.reuseIdentifier)
        reposTableView.rowHeight = 60
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
        guard let repoCell = self.tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseIdentifier, for: indexPath) as? RepoTableViewCell, let repoModel = self.repoModelArray else {
            return UITableViewCell()
        }

        let repo = repoModel[indexPath.row]
        repoCell.configureCell(repoName: repo.name ?? "", repoLang: repo.language ?? "")

        return repoCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repoModel = self.repoModelArray else {return}
        self.repo = repoModel[indexPath.row]
        performSegue(withIdentifier: Constants.repoDetailSegue, sender: self)
    }
    

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.repoDetailSegue {
            if let destination = segue.destination as? RepoDetailViewController {
                destination.repo = self.repo
                destination.navigationItem.title = self.repo?.name ?? ""

            }
        }
    }

    private func setupUI() {
        let colors: [UIColor] = [FlatWhite(), FlatNavyBlue()]
        let bgView = UIView(frame: self.view.frame)
        bgView.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: reposTableView.frame, colors: colors)
        self.reposTableView.backgroundView = bgView
        navigationController?.navigationBar.backgroundColor = FlatGrayDark()
    }

    


}
