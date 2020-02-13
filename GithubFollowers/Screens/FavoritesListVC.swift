//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {
	
	let tableView = UITableView()
	var favorites: [Follower] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureViewController()
		self.configureTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.getFavorites()
	}
	
	func configureViewController() {
		self.view.backgroundColor = .systemBackground
		self.title = "Favorites"
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func configureTableView() {
		self.view.addSubview(self.tableView)
		self.tableView.frame = self.view.bounds
		self.tableView.rowHeight = 80
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.removeExcessCells()
		
		self.tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
	}
	
	func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] (result) in
			guard let self = self else { return }
			
			switch result {
			case .success(let favorites):
				self.updateUI(with: favorites)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	func updateUI(with favorites: [Follower]) {
		if favorites.isEmpty {
			self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
		} else {
			self.favorites = favorites
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.view.bringSubviewToFront(self.tableView)
			}
		}
	}
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.favorites.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
		let favorite = self.favorites[indexPath.row]
		cell.set(favorite: favorite)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite = self.favorites[indexPath.row]
		let destVC = FollowerListVC(username: favorite.login)
		
		self.navigationController?.pushViewController(destVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		guard editingStyle == .delete else { return }
		
		PersistenceManager.updateWith(favorite: self.favorites[indexPath.row], actionType: .remove) { [weak self](error) in
			guard let self = self else { return }
			
			guard let error = error else {
				self.favorites.remove(at: indexPath.row)
				self.tableView.deleteRows(at: [indexPath], with: .left)
				return
			}
			self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
		}
	}
}
