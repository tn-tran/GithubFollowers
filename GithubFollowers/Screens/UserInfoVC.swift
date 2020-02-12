//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/6/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit


protocol UserInfoVCDelegate: class {
	func didTapGitHubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
	
	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	var itemViews: [UIView] = []
	let dateLabel = GFBodyLabel(textAlignment: .center)
	
	var username: String!
	weak var delegate: FollowerListVCDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureViewController()
		self.layoutUI()
		self.getUserInfo()
	}
	
	func layoutUI() {
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
		self.itemViews = [self.headerView, self.itemViewOne, self.itemViewTwo, self.dateLabel]
		
		for itemView in itemViews {
			self.view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate ([
				itemView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
			])
		}
		
		
		NSLayoutConstraint.activate([
			self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			self.headerView.heightAnchor.constraint(equalToConstant: 180),
			
			self.itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: padding),
			self.itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			self.itemViewTwo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
			self.itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			self.dateLabel.topAnchor.constraint(equalTo: self.itemViewTwo.bottomAnchor, constant: padding),
			self.dateLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}
	
	func configureViewController(){
		self.view.backgroundColor = .systemBackground
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissVC))
		
		self.navigationItem.rightBarButtonItem = doneButton
	}
	
	func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: self.username) { [weak self] (result) in
			guard let self = self else { return }
			
			switch result {
			case .success(let user):
				DispatchQueue.main.async {
					self.configureUIElements(with: user)
				}
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	func configureUIElements(with user: User) {
		let repoItemVC = GFRepoItemVC(user: user)
		repoItemVC.delegate = self
		
		let followerItemVC = GFFollowerItemVC(user: user)
		followerItemVC.delegate = self
		
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.add(childVC: repoItemVC, to: self.itemViewOne)
		self.add(childVC: followerItemVC, to: self.itemViewTwo)
		
		self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
	}
	
	func add(childVC: UIViewController, to containerView: UIView) {
		self.addChild(childVC)
		containerView .addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
	
	@objc func dismissVC() {
		self.dismiss(animated: true)
	}
	
}

extension UserInfoVC: UserInfoVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid URL", message: "This url attached to this user ins invalid", buttonTitle: "Ok")
			return
		}

		self.presentSafariVC(with: url)
	}
	
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			self.presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers.", buttonTitle: "Ok")
			return
		}
		self.delegate.didRequestFollowers(for: user.login)
		self.dismissVC()
	}
	
}
