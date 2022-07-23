//
//  ViewController.swift
//  GitHubAPI
//
//  Created by test on 25.06.2022.
//

import UIKit

// check out
// https://docs.github.com/en/rest

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var repos: [Repository]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData(){
        NetworkingHelpers.decodeData(from: "https://api.github.com/repositories", type: [Repository].self, printJSON: false) { [weak self] data in
            
            //print(data)
            
            self?.repos = data
            self?.tableView.reloadData()
        }
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell") as! ReposTableViewCell
        if let repos = repos{
            cell.setData(repository: repos[indexPath.row])
        }
        return cell
    }
}
