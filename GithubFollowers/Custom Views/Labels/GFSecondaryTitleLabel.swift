//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/9/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(fontSize: CGFloat) {
		self.init(frame: .zero)
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
		
	}
	
	private func configure() {
		self.textColor = .secondaryLabel
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.90
		self.lineBreakMode = .byTruncatingTail
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
