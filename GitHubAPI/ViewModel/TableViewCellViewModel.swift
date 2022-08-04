//
//  TableViewCellViewModel.swift
//  GitHubAPI
//
//  Created by test on 25.07.2022.
//

import Foundation

class TableViewCellViewModel{
    
    private var repository: Repository
    
    var repoId: String { "\(repository.id)" }
    var repoName: String { repository.name }
    var repoOwnerName: String { repository.owner.login }
    var repoDescription: String { repository.description != nil ? repository.description! : "" }
    var repoLink: String { repository.html_url }
    var repoOwnerAvatarUrl: String { repository.owner.avatar_url }
    
    var repoURL: URL? {
        URL(string: repoLink)
    }
    
    var repoCellSizes: RepoCellSizes!
    
    init(repository: Repository){
        self.repository = repository
    }
}
