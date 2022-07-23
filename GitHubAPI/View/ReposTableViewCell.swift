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
    
    func setData(repository: Repository){
        repoId.text = "\(repository.id)"
        repoName.text = "\(repository.name)"
        ownerName.text = "\(repository.owner.login)"
        //repoDescription.text = "\(repository.description)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
