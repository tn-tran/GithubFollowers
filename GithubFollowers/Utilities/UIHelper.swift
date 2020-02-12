//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/4/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

struct UIHelper {
	static func createThreeColumnFlowLayout(in view: UIView)  -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minimumItemSpacing: CGFloat = 10
		
		let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
	
		return flowLayout
	}
}