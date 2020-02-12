//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		//custom code
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(backgroundColor: UIColor, title: String) {
		super.init(frame: .zero)
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
		self.configure()
	}
	
	private func configure() {
		self.layer.cornerRadius = 10
		self.setTitleColor(.white, for: .normal)
		self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		self.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
	}
}
