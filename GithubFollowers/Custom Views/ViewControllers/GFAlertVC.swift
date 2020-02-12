//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
	
	let containerView = UIView()
	let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
	let messageLabel = GFBodyLabel(textAlignment: .center)
	let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
	
	var alertTitle: String?
	var message: String?
	var buttonTitle: String?
	
	let padding: CGFloat = 20
	
	init(title: String, message: String, buttonTitle: String) {
		super.init(nibName: nil, bundle: nil)
		self.alertTitle = title
		self.message = message
		self.buttonTitle = buttonTitle
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
		self.configureContainerView()
		self.configureTitleLabel()
		self.configureActionButton()
		self.configureMessageLabel()
		
	}
	
	func configureContainerView() {
		self.view.addSubview(self.containerView)
		self.containerView.backgroundColor = .systemBackground
		self.containerView.layer.cornerRadius = 16
		self.containerView.layer.borderWidth = 2
		self.containerView.layer.borderColor = UIColor.white.cgColor
		self.containerView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.containerView.widthAnchor.constraint(equalToConstant: 280),
			self.containerView.heightAnchor.constraint(equalToConstant: 220),
		])
	}
	
	func configureTitleLabel() {
		self.containerView.addSubview(self.titleLabel)
		self.titleLabel.text  = self.alertTitle ?? "Something went wrong"
		
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: self.padding),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
			self.titleLabel.heightAnchor.constraint(equalToConstant: 28)
		])
	}
	
	func configureActionButton() {
		self.containerView.addSubview(self.actionButton)
		self.actionButton.setTitle(self.buttonTitle ?? "Ok", for: .normal)
		self.actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			self.actionButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -self.padding),
			self.actionButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
			self.actionButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
			self.actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
	
	func configureMessageLabel() {
		self.containerView.addSubview(self.messageLabel)
		self.messageLabel.text = self.message ?? "Unable to complete request"
		self.messageLabel.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 9),
			self.messageLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: self.padding),
			self.messageLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -self.padding),
			self.messageLabel.bottomAnchor.constraint(equalTo: self.actionButton.topAnchor, constant: -12)
		])
	}
	@objc func dismissVC() {
		self.dismiss(animated: true)
	}
}
