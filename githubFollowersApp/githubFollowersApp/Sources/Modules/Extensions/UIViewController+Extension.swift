//
//  UIViewController+Extension.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(title: String,
                                  message: String,
                                  buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = CustomAlertViewController(title: title,
                                                                message: message,
                                                                buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
