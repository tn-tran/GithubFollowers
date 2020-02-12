//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
		super.init(frame: .zero)
		self.textAlignment = textAlignment
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
		self.configure()
	}
	
	private func configure() {
		self.textColor = .label
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.9
		self.lineBreakMode = .byTruncatingTail
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
