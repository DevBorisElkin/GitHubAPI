//
//  ReposTableViewCell.swift
//  GitHubAPI
//
//  Created by test on 23.07.2022.
//

import UIKit

class ReposTableViewCell: UITableViewCell {

    @IBOutlet weak var repoId: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var repoDescription: UITextView!
    
    func setData(viewModel: TableViewCellViewModel){
        repoId.text = viewModel.repoId
        repoName.text = viewModel.repoName
        ownerName.text = viewModel.repoOwnerName
        repoDescription.text = viewModel.repoDescription
    }
}
