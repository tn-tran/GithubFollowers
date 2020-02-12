//
//  GFAlertContainerView.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/12/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		self.backgroundColor = .systemBackground
		self.layer.cornerRadius = 16
		self.layer.borderWidth = 2
		self.layer.borderColor = UIColor.white.cgColor
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
