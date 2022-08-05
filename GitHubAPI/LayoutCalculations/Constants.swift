//
//  Constants.swift
//  GitHubAPI
//
//  Created by test on 04.08.2022.
//

import Foundation
import UIKit

/// this are general insets from all edjes of table view cell view
class Constants {
    
    // MARK: Fonts
    static let repoNameFont = UIFont.systemFont(ofSize: 25, weight: .medium)
    static let repoOwnerFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let repoIdFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let repoDescriptionFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    // MARK: General insets and values:
    // card view offsets from parent view
    static let cardViewOffset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let repoOwnerAvatarSize: CGFloat = 30
    static var screenWidth: CGFloat = UIScreen.main.bounds.width
    static var cardViewWidth = Constants.screenWidth - Constants.cardViewOffset.left - Constants.cardViewOffset.right
    static var repoDescriptionTextWidthWithCardView: CGFloat = cardViewWidth - repoDescriptionInsets.left - repoDescriptionInsets.right
    
    // MARK: Different view's insets
    static let repoNameInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    static let repoOwnerAvatarInsets = UIEdgeInsets(top: 7, left: 13, bottom: 13, right: 13)
    static let repoOwnerInsets = UIEdgeInsets(top: 13, left: 7, bottom: 13, right: 13)
    static let repoIdInsets = UIEdgeInsets(top: 15, left: 7, bottom: 13, right: 13)
    static let repoDescriptionInsets = UIEdgeInsets(top: 95, left: 13, bottom: 45, right: 13)
    
    // MARK: Colors
    static let gitgubColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
    static let gitgubPageBottomColor = #colorLiteral(red: 0.231372549, green: 0.2235294118, blue: 0.2705882353, alpha: 1)
    static let gitgubWhiteColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    //static let cardViewTopColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    //static let cardViewBottomColor = #colorLiteral(red: 0.6706476808, green: 0.2497586012, blue: 0.9693264365, alpha: 1)
    static let cardViewTopColor = #colorLiteral(red: 0.6948638793, green: 0.5592857087, blue: 0.9686274529, alpha: 1)
    static let cardViewBottomColor = #colorLiteral(red: 0.8008915726, green: 0.5635382507, blue: 0.9693264365, alpha: 1)
}
