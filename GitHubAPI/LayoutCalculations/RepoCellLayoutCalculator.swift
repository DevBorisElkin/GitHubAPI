//
//  RepoCellLayoutCalculator.swift
//  GitHubAPI
//
//  Created by test on 04.08.2022.
//

import Foundation
import UIKit

final class RepoCellLayoutCalculator {
    static func calculateCellSizes(selectedRepo: Repository) -> RepoCellSizes {
        
        var repoDescriptionFrame = CGRect(origin: CGPoint(x: Constants.repoDescriptionInsets.left, y: Constants.repoDescriptionInsets.top), size: CGSize.zero)
        
        if let repoDescription = selectedRepo.description, !repoDescription.isEmpty{
            let width = Constants.repoDescriptionTextWidthWithCardView
            let height = repoDescription.height(width: width, font: Constants.repoDescriptionFont)
            
            repoDescriptionFrame.size = CGSize(width: width, height: height)
        }
        //print("Calculated text height for item \(selectedRepo.id): \(repoDescriptionFrame.size.height)")
        
        // MARK: Calculate cell height
        let cellTotalHeight: CGFloat = Constants.repoDescriptionInsets.top + repoDescriptionFrame.height + Constants.repoDescriptionInsets.bottom
        
        print("Calculated cell total height for item \(selectedRepo.id): \(cellTotalHeight)")
        
        return RepoCellSizes(repoDescriptionFrame: repoDescriptionFrame,
                             repoCellHeight: cellTotalHeight)
    }
}
