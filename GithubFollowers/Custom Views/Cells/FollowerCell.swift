//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/4/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
	
	static let reuseID = "FollowerCell"
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(follower: Follower) {
		self.avatarImageView.downloadImage(fromURL: follower.avatarUrl)
		self.usernameLabel.text = follower.login
	}
	
	private func configure() {
		self.addSubviews(self.avatarImageView, self.usernameLabel)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			self.avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
			self.avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
			self.avatarImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
			self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
			
			self.usernameLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 12),
			self.usernameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
			self.usernameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
			self.usernameLabel.heightAnchor.constraint(equalToConstant: 20)
			
		])
	}
}
