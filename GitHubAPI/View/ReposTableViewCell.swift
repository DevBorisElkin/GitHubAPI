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
    
    let repoId: PaddingLabel = {
        var label = PaddingLabel()
        label.setInsets(insets: UIEdgeInsets(top: 3, left: 10, bottom: 4, right: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.repoIdFont
        label.backgroundColor = #colorLiteral(red: 0.9666337371, green: 0.9589776397, blue: 0.9079719186, alpha: 1)
        label.textColor = #colorLiteral(red: 0.4477045536, green: 0.4294939339, blue: 0.4558002353, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    let repoName: PaddingLabel = {
        var label = PaddingLabel()
        label.setInsets(insets: UIEdgeInsets(top: 3, left: 5, bottom: 4, right: 5))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.repoNameFont
        label.backgroundColor = #colorLiteral(red: 0.9666337371, green: 0.9589776397, blue: 0.9079719186, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        
        return label
    }()
    let ownerName: PaddingLabel = {
        var label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.repoOwnerFont
        label.backgroundColor = #colorLiteral(red: 0.9666337371, green: 0.9589776397, blue: 0.9079719186, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    let repoDescription: UITextView = {
        var label = UITextView()
        //label.translatesAutoresizingMaskIntoConstraints = false
        //label.setInsets(insets: UIEdgeInsets(top: 3, left: 5, bottom: 4, right: 5))
//        label.font = Constants.repoDescriptionFont
//        label.lineBreakMode = .byClipping
//        label.numberOfLines = 0
//        label.backgroundColor = #colorLiteral(red: 0.9666337371, green: 0.9589776397, blue: 0.9079719186, alpha: 1)
//        label.layer.cornerRadius = 10
//        label.layer.masksToBounds = true
        
        //
        label.backgroundColor = .red
        
        label.font = Constants.repoDescriptionFont
        label.isScrollEnabled = false
        label.isSelectable = true
        label.isUserInteractionEnabled = true
        label.isEditable = false
        
        let padding = label.textContainer.lineFragmentPadding
        label.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        
        label.dataDetectorTypes = UIDataDetectorTypes.all
        //
        return label
    }()
    let repoOwnerImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.repoOwnerAvatarSize / 2
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
        
        // MARK: Repo name
        cardView.addSubview(repoName)
        repoName.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: Constants.repoNameInsets)
        
        // MARK: Repo owner Image
        cardView.addSubview(repoOwnerImageView)
        repoOwnerImageView.heightAnchor.constraint(equalToConstant: Constants.repoOwnerAvatarSize).isActive = true
        repoOwnerImageView.widthAnchor.constraint(equalToConstant: Constants.repoOwnerAvatarSize).isActive = true
        repoOwnerImageView.topAnchor.constraint(equalTo: repoName.bottomAnchor, constant: Constants.avatarTopInsetToRepoName).isActive = true
        repoOwnerImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.generalInsets.left).isActive = true
        
        // MARK: Repo owner Name
        cardView.addSubview(ownerName)
//        ownerName.anchor(top: repoName.bottomAnchor, leading: repoOwnerImageView.trailingAnchor, bottom: nil, trailing: nil, padding: Constants.generalInsets)
        ownerName.centerYAnchor.constraint(equalTo: repoOwnerImageView.centerYAnchor).isActive = true
        ownerName.leadingAnchor.constraint(equalTo: repoOwnerImageView.trailingAnchor, constant: Constants.repoOwnerInsets.left).isActive = true
        
        // MARK: Repo ID
        cardView.addSubview(repoId)
        repoId.centerYAnchor.constraint(equalTo: repoName.centerYAnchor).isActive = true
        repoId.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.repoIdInsets.right).isActive = true
        
        // MARK: repo description
        cardView.addSubview(repoDescription)
//        repoDescription.anchor(top: repoOwnerImageView.bottomAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: Constants.generalInsets)
//        repoDescription.frame = CGRect(x: cardView.frame.origin.x + Constants.generalInsets.left, y: repoOwnerImageView.frame.maxY, width: frame.width - Constants.generalInsets.left - Constants.generalInsets.right, height: 300)
    }
    
    func setData(viewModel: TableViewCellViewModel){
        repoId.text = viewModel.repoId
        repoName.text = viewModel.repoName
        ownerName.text = viewModel.repoOwnerName
        repoDescription.text = viewModel.repoDescription
        
        repoOwnerImageView.set(imageURL: viewModel.repoOwnerAvatarUrl)
        
        // MARK: Adjust repo description frame
        
        let cardViewWidth = Constants.getScreenWidth() - Constants.cardViewOffset.left - Constants.cardViewOffset.right
        let width = cardViewWidth - Constants.repoDescriptionInsets.left - Constants.repoDescriptionInsets.right
        
        var repoDescriptionFrame = CGRect(origin: CGPoint(x: Constants.repoDescriptionInsets.left, y: Constants.repoDescriptionInsets.top), size: CGSize.zero)
        
        repoDescriptionFrame.size = CGSize(width: width, height: 100)
        
        repoDescription.frame = repoDescriptionFrame
    }
}
