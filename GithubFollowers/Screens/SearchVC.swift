//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
	
	let logoImageView = UIImageView()
	let usernameTextField = GFTextField()
	let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
	var logoImageViewTopConstraint = NSLayoutConstraint()
	
	var isUsernameEntered: Bool {
		return !self.usernameTextField.text!.isEmpty
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		self.configureLogoImageView()
		self.configureTextField()
		self.configreCallToActionButton()
		self.createDismissTapGesture()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.usernameTextField.text = ""
		self.navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	func createDismissTapGesture() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
		self.view.addGestureRecognizer(tap
		)
	}
	
	@objc func pushFollowerListVC() {
		guard self.isUsernameEntered else {
			self.presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username", buttonTitle: "Ok")
			return
		}
		
		self.usernameTextField.resignFirstResponder()
		
		let followerListVC = FollowerListVC(username: usernameTextField.text!)
		
		self.navigationController?.pushViewController(followerListVC, animated: true)
	}
	
	func configureLogoImageView() {
		self.view.addSubview(self.logoImageView)
		self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
		self.logoImageView.image = Images.ghLogo
		
		let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
		
		self.logoImageViewTopConstraint = self.logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
		
		self.logoImageViewTopConstraint.isActive = true
		
		NSLayoutConstraint.activate([
			self.logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
			self.logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
			self.logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	func configureTextField() {
		self.view.addSubview(self.usernameTextField)
		self.usernameTextField.delegate = self
		
		NSLayoutConstraint.activate([
			self.usernameTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
			self.usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
			self.usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
			self.usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func configreCallToActionButton() {
		self.view.addSubview(self.callToActionButton)
		self.callToActionButton.addTarget(self, action: #selector(self.pushFollowerListVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			self.callToActionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide .bottomAnchor, constant: -50),
			self.callToActionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
			self.callToActionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
			self.callToActionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}

extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.pushFollowerListVC()
		return true
	}
}
