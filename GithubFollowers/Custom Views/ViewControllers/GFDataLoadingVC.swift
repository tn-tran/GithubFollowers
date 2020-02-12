//
//  GFDataLoadingVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/12/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {

 	fileprivate var containerView: UIView!
	
	func showLoadingView() {
		self.containerView = UIView(frame: view.bounds)
		self.view.addSubview(containerView)
		
		self.containerView.backgroundColor = .systemBackground
		self.containerView.alpha = 0
		
		UIView.animate(withDuration: 0.25) {
			self.containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		self.containerView.addSubview(activityIndicator)
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			self.containerView.removeFromSuperview()
			self.containerView = nil
		}
	}
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView = GFEmptyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}

}
