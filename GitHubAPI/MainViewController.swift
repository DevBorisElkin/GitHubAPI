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
    
    let githubReposLink = "https://api.github.com/repositories"
    let githubReposPaginationLink = "https://api.github.com/repositories?since="
    
    var screenHeight: CGFloat!
    let screenHeightOffsetToPaginate = 0.25 // e.g. 0.2 = 20% of screen swiped = load next page
    var contentSizeSubtraction: Double!
    
    var fetchingData: Bool = true
    var lastRepoLoadedId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenHeight = UIScreen.main.bounds.height
        //contentSizeSubtraction = screenHeight * (1 - screenHeightOffsetToPaginate)
        contentSizeSubtraction = view.frame.size.height + Double(100)
        loadDataInitially()
    }
    
    func loadDataInitially(){
        NetworkingHelpers.decodeDataDetailed(from: githubReposLink, type: [Repository].self, printJSON: false) { [weak self] data in
            
            self?.repos = data
            self?.tableView.reloadData()
            self?.fetchingData = false
            self?.lastRepoLoadedId = data.last?.id
            
            print("Number of repos: \(data.count)")
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

// MARK: pagination related code
extension MainViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard fetchingData == false else { return }
        
        let position = scrollView.contentOffset.y
        
        if(position > tableView.contentSize.height - contentSizeSubtraction){
            
            print("fetch more data")
            fetchMoreData()
        }
    }
    
    func fetchMoreData(){
        guard fetchingData == false, let lastRepoLoadedId = self.lastRepoLoadedId else { print("unknown error"); return }
        
        print("Load more repos data")
        fetchingData = true
        
        NetworkingHelpers.decodeDataDetailed(from: githubReposPaginationLink + "\(lastRepoLoadedId)", type: [Repository].self, printJSON: false) { [weak self, lastRepoLoadedId] data in
            
            self?.repos?.append(contentsOf: data)
            self?.tableView.reloadData()
            
            self?.lastRepoLoadedId = data.last?.id
            self?.fetchingData = false
            
            print("Now total repos count: \(self?.repos?.count)")
        }
    }
}
