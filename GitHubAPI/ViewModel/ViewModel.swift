//
//  ViewModel.swift
//  GitHubAPI
//
//  Created by test on 25.07.2022.
//

import UIKit
import Foundation

class ViewModel{
    
    // MARK: Core data
    
    private let githubReposPaginationLink = "https://api.github.com/repositories?since="
    
    private var repos = [Repository]()
    var selectedRow: Int?
    
    var fetchingData: Bool = true
    var lastRepoLoadedId: Int = 0
    
    var refreshControl: UIRefreshControl?
    
    // MARK: Ways to get data
    
    var repoCellIdentifier: String{
        "repositoryCell"
    }
    
    var repoDetailsSegueIdentifier: String{
        "showRepositoryDetails"
    }
    
    func getGithubRepositoriesLink(previousRepoId: Int = 0) -> String{
        "\(githubReposPaginationLink)\(previousRepoId)"
    }
    
    func setRepositories(newRepos: [Repository]){
        repos = newRepos
    }
    
    func addNewRepositories(newRepos: [Repository]){
        repos.append(contentsOf: newRepos)
    }
    
    func numberOfRows() -> Int{ return repos.count }
    
    func getRepositoryData(for indexPath: IndexPath) -> TableViewCellViewModel{
        return TableViewCellViewModel(repository: repos[indexPath.row])
    }
    func getRepositoryDataForCelectedCell() -> TableViewCellViewModel?{
        guard let selectedRow = selectedRow else {
            return nil
        }
        return TableViewCellViewModel(repository: repos[selectedRow])
    }
    
    func rowWasSelected(rowIndex indexPath: IndexPath){
        selectedRow = indexPath.row
    }
}
