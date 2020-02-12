//
//  GFError.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/6/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import Foundation

enum GFError: String, Error {
	case invalidUsername = "This username created an invalid request."
	case unableToComplete = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "Invalid response from the server, please try again."
	case invalidData = "The data received from the server was invalid. Please try again."
	case unableToFavorite = "There was an error favoriting this error. Please tr again."
	case alreadyInFavorites = "You've already favorited this user."
}
