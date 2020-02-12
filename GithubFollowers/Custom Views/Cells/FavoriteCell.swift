//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/11/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
	
	static let reuseID = "FavoriteCell"
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(favorite: Follower) {
		self.usernameLabel.text = favorite.login
		NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] (image) in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.avatarImageView.image = image
			}
		}
	}
	
	private func configure() {
		self.addSubview(self.avatarImageView)
		self.addSubview(self.usernameLabel)
		self.accessoryType = .disclosureIndicator
		let padding: CGFloat = 12
		
		NSLayoutConstraint.activate([
			self.avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
			self.avatarImageView.heightAnchor.constraint(equalToConstant: 60),
			self.avatarImageView.widthAnchor.constraint(equalToConstant: 60),
			
			self.usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.usernameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 24),
			self.usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
			self.usernameLabel.heightAnchor.constraint(equalToConstant: 40	)
		])
	}
}
