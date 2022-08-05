//
//  UIHelpers.swift
//  GitHubAPI
//
//  Created by test on 25.07.2022.
//

import UIKit
import Foundation

class UIHelpers{
    
    /// for example, frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
    public static func createSpinnerFooter(frame: CGRect) -> UIView{
        let footerView = UIView(frame: frame)
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        return footerView
    }
}

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : font],
            context: nil
        )
        
        return ceil(size.height)
    }
}
