//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/5/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

	let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
	let logoImageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(message: String) {
		super.init(frame: .zero)
		self.messageLabel.text = message
		self.configure()
	}
	
	private func configure() {
		self.addSubview(self.messageLabel)
		self.addSubview(self.logoImageView)
		
		self.messageLabel.numberOfLines = 3
		self.messageLabel.textColor = .secondaryLabel
		
		self.logoImageView.image = UIImage(named: "empty-state-logo")
		self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
			self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
			self.messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
			self.messageLabel.heightAnchor.constraint(equalToConstant: 200),
			
			self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
			self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
		])
	}
}
