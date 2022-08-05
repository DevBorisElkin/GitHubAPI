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
        
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        
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
        
        // add minimum scale if text is too long
        label.numberOfLines = 1;
        label.minimumScaleFactor = 8/label.font.pointSize;
        label.adjustsFontSizeToFitWidth = true;
        
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
        
        label.font = Constants.repoDescriptionFont
        label.isScrollEnabled = false
        label.isSelectable = true
        label.isUserInteractionEnabled = true
        label.isEditable = false
        
        let padding = label.textContainer.lineFragmentPadding
        label.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        
        label.dataDetectorTypes = UIDataDetectorTypes.all
        
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.9666337371, green: 0.9589776397, blue: 0.9079719186, alpha: 1)
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
        
        // MARK: Repo ID constraints
        cardView.addSubview(repoId)
        repoId.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.repoNameInsets.top).isActive = true
        repoId.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.repoIdInsets.right).isActive = true
        
        // MARK: Repo name constraints
        cardView.addSubview(repoName)
        repoName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.repoNameInsets.left).isActive = true
        repoName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.repoNameInsets.top).isActive = true
        repoName.trailingAnchor.constraint(lessThanOrEqualTo: repoId.leadingAnchor, constant: -Constants.repoNameInsets.right).isActive = true
        
        // MARK: Repo owner Image constraints
        cardView.addSubview(repoOwnerImageView)
        repoOwnerImageView.heightAnchor.constraint(equalToConstant: Constants.repoOwnerAvatarSize).isActive = true
        repoOwnerImageView.widthAnchor.constraint(equalToConstant: Constants.repoOwnerAvatarSize).isActive = true
        repoOwnerImageView.topAnchor.constraint(equalTo: repoName.bottomAnchor, constant: Constants.repoOwnerAvatarInsets.top).isActive = true
        repoOwnerImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.repoOwnerAvatarInsets.left).isActive = true
        
        // MARK: Repo owner Name constraints
        cardView.addSubview(ownerName)
        ownerName.centerYAnchor.constraint(equalTo: repoOwnerImageView.centerYAnchor).isActive = true
        ownerName.leadingAnchor.constraint(equalTo: repoOwnerImageView.trailingAnchor, constant: Constants.repoOwnerInsets.left).isActive = true
        
        // MARK: repo description constraints
        // constraints set in code from view model
        cardView.addSubview(repoDescription)
    }
    
    func setData(viewModel: TableViewCellViewModel){
        repoId.text = viewModel.repoId
        repoName.text = viewModel.repoName
        ownerName.text = viewModel.repoOwnerName
        repoDescription.text = viewModel.repoDescription
        repoOwnerImageView.set(imageURL: viewModel.repoOwnerAvatarUrl)
        
        // MARK: hard 'constraints' by frame
        repoDescription.frame = viewModel.repoCellSizes.repoDescriptionFrame
    }
}
