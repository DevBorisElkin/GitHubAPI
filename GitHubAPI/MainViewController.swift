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
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData(){
        NetworkingHelpers.decodeDataDetailed(from: "https://api.github.com/repositories", type: [Repository].self, printJSON: false) { [weak self] data in
            
            //print(data)
            
            self?.repos = data
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepositoryDetails", let repos = self.repos, let selectedRow = selectedRow{
            var detailViewController = segue.destination as! RepoDetailsViewController
            detailViewController.setData(repository: repos[selectedRow])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "showRepositoryDetails", sender: nil)
    }
}
