//
//  TitleView.swift
//  GitHubAPI
//
//  Created by test on 05.08.2022.
//

import Foundation
import UIKit

class TitleView: UIView {
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GitHub Repositories"
        label.font = Constants.pageTitleFont
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "github_1")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        
        addSubview(stackView)
        stackView.fillSuperview()
        
        label.heightAnchor.constraint(equalToConstant: Constants.titleViewImageSize).isActive = true
        label.widthAnchor.constraint(equalToConstant: Constants.titleViewTextWidth).isActive = true
        image.heightAnchor.constraint(equalToConstant: Constants.titleViewImageSize).isActive = true
        image.widthAnchor.constraint(equalToConstant: Constants.titleViewImageSize).isActive = true
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
    }
}
