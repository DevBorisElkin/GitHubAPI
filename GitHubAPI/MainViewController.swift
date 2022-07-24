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
    
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenHeight = UIScreen.main.bounds.height
        //contentSizeSubtraction = screenHeight * (1 - screenHeightOffsetToPaginate)
        contentSizeSubtraction = view.frame.size.height + Double(100)
        
        tableView.refreshControl = createRefreshControl()
        
        
        loadDataInitially(completion: nil)
    }
    
    func loadDataInitially(completion: (() -> ())?){
        NetworkingHelpers.decodeDataDetailed(from: githubReposLink, type: [Repository].self, printJSON: false) { [weak self] data in
            
            self?.repos = data
            self?.tableView.reloadData()
            self?.fetchingData = false
            self?.lastRepoLoadedId = data.last?.id
            
            print("Number of repos: \(data.count)")
            
            completion?()
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
        
        self.tableView.tableFooterView = createSpinnerFooter()
        
        // this thing is only for delay TODO fix it
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            // TODO with that there's potentially a memory leak
            NetworkingHelpers.decodeDataDetailed(from: self.githubReposPaginationLink + "\(lastRepoLoadedId)", type: [Repository].self, printJSON: false) { [weak self, lastRepoLoadedId] data in
                
                self?.tableView.tableFooterView = nil
                
                self?.repos?.append(contentsOf: data)
                self?.tableView.reloadData()
                
                self?.lastRepoLoadedId = data.last?.id
                self?.fetchingData = false
                
                print("Now total repos count: \(self?.repos?.count)")
            }
        }
    }
    
    private func createSpinnerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        return footerView
    }
}
// MARK: pull to refresh
extension MainViewController{
    
    private func createRefreshControl() -> UIRefreshControl{
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onCalledToRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc private func onCalledToRefresh(sender: UIRefreshControl){
        loadDataInitially {
            sender.endRefreshing()
        }
    }
}
