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
	
	convenience init(message: String) {
		self.init(frame: .zero)
		self.messageLabel.text = message
	}
	
	private func configure() {
		self.addSubviews(self.messageLabel, self.logoImageView)
		self.configureMessageLabel()
		self.configureLogoImageView()
	}
	
	private func configureMessageLabel() {
		self.messageLabel.numberOfLines = 3
		self.messageLabel.textColor = .secondaryLabel
		
		let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
		
		NSLayoutConstraint.activate([
			self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
			self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
			self.messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
			self.messageLabel.heightAnchor.constraint(equalToConstant: 200)
		])
	}
	
	private func configureLogoImageView() {
		self.logoImageView.image = Images.emptyStateLogo
		self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
		
		NSLayoutConstraint.activate([
			self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
			self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
		])
	}
}
