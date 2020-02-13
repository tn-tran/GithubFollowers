//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/6/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

protocol UserInfoVCVCDelegate: class {
	func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
	
	let scrollView = UIScrollView()
	let contentView = UIView()
	
	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	
	var itemViews: [UIView] = []
	let dateLabel = GFBodyLabel(textAlignment: .center)
	
	var username: String!
	weak var delegate: UserInfoVCVCDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureViewController()
		self.layoutUI()
		self.getUserInfo()
		self.configureScrollView()
	}
	
	func layoutUI() {
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
		self.itemViews = [self.headerView, self.itemViewOne, self.itemViewTwo, self.dateLabel]
		
		for itemView in itemViews {
			self.contentView.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate ([
				itemView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
			])
		}
		
		NSLayoutConstraint.activate([
			self.headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			self.headerView.heightAnchor.constraint(equalToConstant: 210),
			
			self.itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: padding),
			self.itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			self.itemViewTwo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
			self.itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			self.dateLabel.topAnchor.constraint(equalTo: self.itemViewTwo.bottomAnchor, constant: padding),
			self.dateLabel.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func configureViewController(){
		self.view.backgroundColor = .systemBackground
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissVC))
		
		self.navigationItem.rightBarButtonItem = doneButton
	}
	
	func configureScrollView() {
		self.view.addSubview(self.scrollView)
		self.scrollView.addSubview(self.contentView)
		
		self.scrollView.pinToEdges(of: self.view)
		self.contentView.pinToEdges(of: self.scrollView)
		
		NSLayoutConstraint.activate([
			self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
			self.contentView.heightAnchor.constraint(equalToConstant: 600)
		])
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
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
		self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
		
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

extension UserInfoVC: GFRepoItemVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid URL", message: "This url attached to this user ins invalid", buttonTitle: "Ok")
			return
		}
		
		self.presentSafariVC(with: url)
	}
	
}

extension UserInfoVC: GFFollowerItemVCDelegate {
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			self.presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers.", buttonTitle: "Ok")
			return
		}
		self.delegate.didRequestFollowers(for: user.login)
		self.dismissVC()
	}
}
