//
//  TableViewCellViewModel.swift
//  GitHubAPI
//
//  Created by test on 25.07.2022.
//

import Foundation

class TableViewCellViewModel{
    
    var repoId: String
    var repoName: String
    var repoOwnerName: String
    var repoDescription: String
    var repoLink: String
    var repoOwnerAvatarUrl: String
    
    var repoURL: URL?
    
    var repoCellSizes: RepoCellSizes
    
    init(repository: Repository){
        repoId = "\(repository.id)"
        repoName = repository.name
        repoOwnerName = repository.owner.login
        repoDescription = repository.description ?? ""
        repoLink = repository.html_url
        repoOwnerAvatarUrl = repository.owner.avatar_url
        repoURL = URL(string: repoLink)
        
        self.repoCellSizes = RepoCellLayoutCalculator.calculateCellSizes(selectedRepo: repository)
    }
}
