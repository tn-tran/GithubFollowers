//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}
	
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredBarTintColor = .systemGreen
		present(safariVC, animated: true)
	}
}
