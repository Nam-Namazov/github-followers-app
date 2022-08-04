//
//  UIView+Extension.swift
//  githubFollowersApp
//
//  Created by Намик on 8/4/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
