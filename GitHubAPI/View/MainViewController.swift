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
        
        prepareTableView()
        initialSetup()
    }
    
    func prepareTableView() {
        tableView.register(ReposTableViewCell.self, forCellReuseIdentifier: ReposTableViewCell.reuseId)
        
    }
    
    func initialSetup(){
        contentSizeSubtraction = view.frame.size.height + Double(100)
        tableView.refreshControl = createRefreshControl()
        loadDataInitially(completion: nil)
    }
    
    func loadDataInitially(completion: (() -> ())?){
        NetworkingHelpers.decodeDataWithResult(from: viewModel.getGithubRepositoriesLink(), type: [Repository].self, printJSON: false) { [weak self] result in
            
            switch result{
            case .success(let repositories):
                self?.viewModel.setRepositories(newRepos: repositories)
                self?.viewModel.lastRepoLoadedId = repositories.last?.id ?? 0
                print("Number of repos: \(repositories.count)")
            case .failure(let error):
                self?.viewModel.setRepositories(newRepos: [])
                self?.viewModel.lastRepoLoadedId = 0
                print("*Couldn't get data = failure")
            }

            self?.tableView.reloadData()
            self?.viewModel.fetchingData = false
            
            completion?()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == viewModel.repoDetailsSegueIdentifier, let preparedViewModel = viewModel.getRepositoryDataForCelectedCell() else {
           return
        }
        
        var detailViewController = segue.destination as! RepoDetailsViewController
        detailViewController.setData(tableViewCellViewModel: preparedViewModel)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepoCellLayoutCalculator.calculateCellHeight()
    }
    
    // MARK: open cell details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowWasSelected(rowIndex: indexPath)
        performSegue(withIdentifier: viewModel.repoDetailsSegueIdentifier, sender: nil)
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
        
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            NetworkingHelpers.decodeDataWithResult(from: self.viewModel.getGithubRepositoriesLink(previousRepoId: self.viewModel.lastRepoLoadedId), type: [Repository].self, printJSON: false){ [weak self] result in
                
                self?.tableView.tableFooterView = nil
                
                switch result{
                case .success(let repositories):
                    self?.viewModel.addNewRepositories(newRepos: repositories)
                    self?.tableView.reloadData()
                    self?.viewModel.lastRepoLoadedId = repositories.last?.id ?? 0
                case .failure(let error):
                    print("Unsuccessfully retrieved data. Error:\n\(error)")
                }
                
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
        print("onCalledToRefresh")
        loadDataInitially {
            sender.endRefreshing()
        }
    }
}
