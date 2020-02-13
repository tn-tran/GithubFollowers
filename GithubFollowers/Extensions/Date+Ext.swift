//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/10/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import Foundation

extension Date {
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		
		return dateFormatter.string(for: self)!
	}
}
