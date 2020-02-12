//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureItems()
	}
	
	private func configureItems() {
		self.itemInfoViewOne.set(itemInfoType: .repos, withCount: self.user.publicRepos)
		self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: self.user.publicGists)
		self.actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
	}
	override func actionButtonTapped() {
		self.delegate.didTapGitHubProfile(for: user)
	}
}
