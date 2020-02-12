//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
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
