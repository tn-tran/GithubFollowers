//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/12/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

extension UIView {
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.topAnchor.constraint(equalTo: superview.topAnchor),
			self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			self.trailingAnchor.constraint(equalTo:superview.trailingAnchor),
			self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)])
	}
	
	func addSubviews(_ views: UIView...) {
		for view in views {
			self.addSubview(view)
		}
	}
}
