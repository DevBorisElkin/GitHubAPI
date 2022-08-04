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
    
    static let repoNameFont = UIFont.systemFont(ofSize: 25, weight: .medium)
    static let repoOwnerFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    static let cardViewOffset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let generalInsets = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 10)
    
    static let avatarTopInsetToRepoName: CGFloat = 7
    
    static let repoNameInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    static let repoOwnerInsets = UIEdgeInsets(top: 13, left: 7, bottom: 13, right: 13)
    
    static let repoOwnerAvatarSize: CGFloat = 30
}
