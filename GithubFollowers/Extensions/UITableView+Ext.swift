//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/13/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

extension UITableView {
	func removeExcessCells() {
		self.tableFooterView = UIView(frame: .zero)
	}
	
	func reloadDataOnMainThread() {
		DispatchQueue.main.async {
			self.reloadData()
		}
	}
}
