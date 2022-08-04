//
//  RepoCellLayoutCalculator.swift
//  GitHubAPI
//
//  Created by test on 04.08.2022.
//

import Foundation
import UIKit

final class RepoCellLayoutCalculator {
    func calculateCellSizes(selectedRepo: Repository) -> RepoCellSizes {
        
        let cardViewWidth = Constants.getScreenWidth() - Constants.cardViewOffset.left - Constants.cardViewOffset.right
        let width = cardViewWidth - Constants.repoDescriptionInsets.left - Constants.repoDescriptionInsets.right
        
        var repoDescriptionFrame = CGRect(origin: CGPoint(x: Constants.repoDescriptionInsets.left, y: Constants.repoDescriptionInsets.top), size: CGSize.zero)
        
        if let repoDescription = selectedRepo.description, !repoDescription.isEmpty{
            let width = CellConstants.repoDescriptionTextWidth
            let height = selectedRepo.repoDescription.height(width: width, font: CellConstants.postLabelFont)
            
            repoDescriptionFrame.size = CGSize(width: width, height: height)
        }
        print("Calculated text height for item \(indexPath.row): \(repoDescriptionFrame.size.height)")
        
        // MARK: Calculate cell height
        var cellTotalHeight: CGFloat = CellConstants.descriptionTextInsets.top + repoDescriptionFrame.height + CellConstants.itemsYOffset + CellConstants.borderYHeight
        
        return RepositoryCellViewModel(cellHeight: cellTotalHeight, repoDescriptionFrame: repoDescriptionFrame, repo: selectedRepo)
    }
}
