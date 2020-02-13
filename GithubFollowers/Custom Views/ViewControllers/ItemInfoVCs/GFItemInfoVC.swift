//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

protocol ItemInfoVCDelegate: class {
	func didTapGitHubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}

class GFItemInfoVC: UIViewController {
	
	let stackView = UIStackView()
	let itemInfoViewOne = GFItemInfoView()
	let itemInfoViewTwo = GFItemInfoView()
	let actionButton = GFButton()
	
	var user: User!
	
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureBackgroundView()
		self.layoutUI()
		self.configureStackView()
		self.configureAction()
	}
	
	private func configureStackView() {
		self.stackView.axis = .horizontal
		self.stackView.distribution = .equalSpacing
		
		self.stackView.addArrangedSubview(self.itemInfoViewOne)
		self.stackView.addArrangedSubview(self.itemInfoViewTwo)
	}
	
	func configureBackgroundView() {
		self.view.layer.cornerRadius = 18
		self.view.backgroundColor = .secondarySystemBackground
	}
	
	private func configureAction() {
		self.actionButton.addTarget(self, action: #selector(self.actionButtonTapped), for: .touchUpInside)
	}
	
	@objc func actionButtonTapped() {
		
	}
	
	private func layoutUI() {
		self.view.addSubviews(self.stackView, self.actionButton) // variadic parameter
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		
		let padding: CGFloat = 20
		
		NSLayoutConstraint.activate([
			self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
			self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
			self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
			self.stackView.heightAnchor.constraint(equalToConstant: 50),
			
			self.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -padding),
			self.actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
			self.actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
			self.actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}
