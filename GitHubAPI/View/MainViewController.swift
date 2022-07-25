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
    
    var viewModel = ViewModel()
    
    var contentSizeSubtraction: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentSizeSubtraction = view.frame.size.height + Double(100)
        tableView.refreshControl = createRefreshControl()
        loadDataInitially(completion: nil)
    }
    
    func loadDataInitially(completion: (() -> ())?){
        NetworkingHelpers.decodeDataDetailed(from: viewModel.getGithubRepositoriesLink(), type: [Repository].self, printJSON: false) { [weak self] data in
            
            self?.viewModel.setRepositories(newRepos: data)

            self?.tableView.reloadData()
            self?.viewModel.fetchingData = false
            self?.viewModel.lastRepoLoadedId = data.last?.id ?? 0
            
            print("Number of repos: \(data.count)")
            
            completion?()
        }
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: viewModel.repoCellIdentifier) as! ReposTableViewCell
        cell.setData(viewModel: viewModel.getRepositoryData(for: indexPath))
        return cell
    }
    
    // MARK: open cell details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowWasSelected(rowIndex: indexPath)
        performSegue(withIdentifier: viewModel.repoDetailsSegueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == viewModel.repoDetailsSegueIdentifier, let preparedViewModel = viewModel.getRepositoryDataForCelectedCell() else {
           return
        }
        
        var detailViewController = segue.destination as! RepoDetailsViewController
        detailViewController.setData(tableViewCellViewModel: preparedViewModel)
    }
}

// MARK: pagination related code
extension MainViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.fetchingData == false else { return }
        
        let position = scrollView.contentOffset.y
        
        if(position > tableView.contentSize.height - contentSizeSubtraction){
            
            print("fetch more data")
            fetchMoreData()
        }
    }
    
    func fetchMoreData(){
        guard viewModel.fetchingData == false else { print("unknown error"); return }
        
        print("Load more repos data")
        viewModel.fetchingData = true
        
        self.tableView.tableFooterView = UIHelpers.createSpinnerFooter(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        // this thing is only for delay TODO fix it
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            // TODO with that there's potentially a memory leak
            NetworkingHelpers.decodeDataDetailed(from: self.viewModel.getGithubRepositoriesLink(), type: [Repository].self, printJSON: false) { [weak self] data in
                
                self?.tableView.tableFooterView = nil
                
                self?.viewModel.addNewRepositories(newRepos: data)
                self?.tableView.reloadData()
                
                self?.viewModel.lastRepoLoadedId = data.last?.id ?? 0
                self?.viewModel.fetchingData = false
                
                print("Now total repos count: \(self?.viewModel.numberOfRows())")
            }
        }
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
