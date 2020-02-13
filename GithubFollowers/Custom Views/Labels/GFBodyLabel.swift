//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
	}
	
	private func configure() {
		self.textColor = .secondaryLabel
		self.font = UIFont.preferredFont(forTextStyle: .body)
		self.adjustsFontForContentSizeCategory = true
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.75
		self.lineBreakMode = .byWordWrapping
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
