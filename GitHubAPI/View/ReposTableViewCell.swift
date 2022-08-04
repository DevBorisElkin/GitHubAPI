//
//  ReposTableViewCell.swift
//  GitHubAPI
//
//  Created by test on 23.07.2022.
//

import UIKit

class ReposTableViewCell: UITableViewCell {

    static let reuseId = "repositoryCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = #colorLiteral(red: 0.800581634, green: 0.589300096, blue: 1, alpha: 1)
        
        // ?
        //view.layer.masksToBounds = true
        //view.clipsToBounds = true
        
        view.layer.shadowColor = #colorLiteral(red: 0.3663252592, green: 0.3663252592, blue: 0.3663252592, alpha: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 5, height: 10)
        
        return view
    }()
    
    let repoId: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let repoName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ownerName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let repoDescription: UITextView = {
        var label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let repoOwnerImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        manageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func manageConstraints(){
        // MARK: cardView
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardViewOffset)
        
        // MARK: add subviews
        
        
        cardView.addSubview(repoId)
        //addSubview(repoName)
        //addSubview(ownerName)
        //addSubview(repoDescription)
        //addSubview(repoOwnerImageView)
        
        // repoId constraints
        repoId.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: Constants.generalInsets.top, left: Constants.generalInsets.left, bottom: 777, right: Constants.generalInsets.right))
    }
    
    func setData(viewModel: TableViewCellViewModel){
        repoId.text = viewModel.repoId
        repoName.text = viewModel.repoName
        ownerName.text = viewModel.repoOwnerName
        repoDescription.text = viewModel.repoDescription
    }
}
