//
//  RepoDetailsViewController.swift
//  GitHubAPI
//
//  Created by test on 24.07.2022.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    
    @IBOutlet weak var selectedRepoName: UILabel!
    
    var selectedRepository: Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedRepoName.text = selectedRepository?.name
    }
    
    public func setData(repository: Repository){
        selectedRepository = repository
    }
}
