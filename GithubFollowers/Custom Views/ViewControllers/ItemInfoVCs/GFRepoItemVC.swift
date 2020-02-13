//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

protocol GFRepoItemVCDelegate: class {
	func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
	
	weak var delegate: GFRepoItemVCDelegate!
	
	init(user: User, delegate: GFRepoItemVCDelegate) {
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
		self.itemInfoViewOne.set(itemInfoType: .repos, withCount: self.user.publicRepos)
		self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: self.user.publicGists)
		self.actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
	}
	
	override func actionButtonTapped() {
		self.delegate.didTapGitHubProfile(for: user)
	}
}
