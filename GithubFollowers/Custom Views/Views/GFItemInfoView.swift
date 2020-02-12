//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

enum ItemInfoType {
	case repos, gists, following, followers
}

class GFItemInfoView: UIView {
	
	let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		self.addSubview(self.symbolImageView)
		self.addSubview(self.titleLabel)
		self.addSubview(self.countLabel)
		
		self.symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		self.symbolImageView.contentMode = .scaleAspectFill
		self.symbolImageView.tintColor = .label
		
		NSLayoutConstraint.activate([
			self.symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
			self.symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			self.symbolImageView.heightAnchor.constraint(equalToConstant: 20),
			
			self.titleLabel.centerYAnchor.constraint(equalTo: self.symbolImageView.centerYAnchor),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.symbolImageView.trailingAnchor, constant: 12),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.titleLabel.heightAnchor.constraint(equalToConstant: 18),
			
			self.countLabel.topAnchor.constraint(equalTo: self.symbolImageView.bottomAnchor, constant: 4),
			self.countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.countLabel.heightAnchor.constraint(equalToConstant: 12)
		])
	}
	
	func set(itemInfoType: ItemInfoType, withCount count: Int) {
		switch itemInfoType {
		case .repos:
			self.symbolImageView.image = UIImage(systemName: SFSymbols.repos)
			self.titleLabel.text = "Public Repos"
		case .gists:
			self.symbolImageView.image = UIImage(systemName: SFSymbols.gists)
			self.titleLabel.text = "Public Gists"
		case .following:
			self.symbolImageView.image = UIImage(systemName: SFSymbols.followers)
			self.titleLabel.text = "Followers"
		case .followers:
			self.symbolImageView.image = UIImage(systemName: SFSymbols.following)
			self.titleLabel.text = "Following"
		}
		self.countLabel.text = String(count)
	}
}
