//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate: class {
	func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
	weak var delegate: GFFollowerItemVCDelegate!
	
	init(user: User, delegate: GFFollowerItemVCDelegate) {
		super.init(user: user)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureItems()
	}
	
	private func configureItems() {
		self.itemInfoViewOne.set(itemInfoType: .followers, withCount: self.user.followers)
		self.itemInfoViewTwo.set(itemInfoType: .following, withCount: self.user.following)
		self.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
	override func actionButtonTapped() {
		self.delegate.didTapGetFollowers(for: user)
	}
}
