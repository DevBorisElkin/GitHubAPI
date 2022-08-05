//
//  Insets.swift
//  GitHubAPI
//
//  Created by test on 04.08.2022.
//

import Foundation
import UIKit

class Constants {
    // this are general insets from all edjes of table view cell view
    
    // MARK: Fonts
    static let repoNameFont = UIFont.systemFont(ofSize: 25, weight: .medium)
    static let repoOwnerFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let repoIdFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let repoDescriptionFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    // MARK: General offsets:
    // card view offsets from parent view
    static let cardViewOffset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    static let avatarTopInsetToRepoName: CGFloat = 7
    
    static let repoNameInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    static let repoOwnerAvatarInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    static let repoOwnerInsets = UIEdgeInsets(top: 13, left: 7, bottom: 13, right: 13)
    static let repoIdInsets = UIEdgeInsets(top: 15, left: 7, bottom: 13, right: 13)
    static let repoDescriptionInsets = UIEdgeInsets(top: 95, left: 13, bottom: 45, right: 13)
    
    static let repoOwnerAvatarSize: CGFloat = 30
    
    static func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var repoDescriptionTextWidth: CGFloat {
        get{
            return UIScreen.main.bounds.width - repoDescriptionInsets.left - repoDescriptionInsets.right
        }
    }
    
    static var cardViewWidth = Constants.getScreenWidth() - Constants.cardViewOffset.left - Constants.cardViewOffset.right
    
    static var repoDescriptionTextWidthWithCardView: CGFloat = cardViewWidth - repoDescriptionInsets.left - repoDescriptionInsets.right
    
    static let minifiedPostLimitLines: CGFloat = 4
}
