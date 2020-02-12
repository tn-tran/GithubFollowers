//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Tien Tran on 2/3/20.
//  Copyright © 2020 Tien-Enterprise. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
	func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
	
	enum Section {
		case main
	}
	
	var username: String!
	var followers: [Follower] = []
	var filteredFollowers: [Follower] = []
	var page = 1
	var hasMoreFollowers = true
	var isSearching = false
	
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username = username
		self.title = username
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureViewController()
		self.configureCollectionView()
		self.getFollowers(username: self.username, page: self.page)
		self.configureDataSource()
		self.configureSearchController()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	func configureViewController() {
		self.view.backgroundColor = .systemBackground
		self.navigationController?.navigationBar.prefersLargeTitles = true
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped))
		
		self.navigationItem.rightBarButtonItem = addButton
	}
	
	func configureCollectionView() {
		self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: self.view))
		self.collectionView.delegate = self
		self.view.addSubview(self.collectionView)
		self.collectionView.backgroundColor = .systemBackground
		self.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	func configureSearchController() {
		let searchController = UISearchController()
		
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for a username"
		searchController.obscuresBackgroundDuringPresentation = false
		self.navigationItem.searchController = searchController
	}
	
	func getFollowers(username: String, page: Int) {
		self.showLoadingView()
		
		NetworkManager.shared.getFollowers(for: self.username, page: self.page) { [weak self] result in
			
			guard let self = self else { return }
			
			self.dismissLoadingView()
			
			switch result {
			case .success(let followers):
				if followers.count < 100 { self.hasMoreFollowers = false }
				
				self.followers.append(contentsOf: followers)
				
				if self.followers.isEmpty {
					let message =  "This user doesn't have any followers"
					DispatchQueue.main.async {
						self.showEmptyStateView(with: message, in: self.view)
					}
					return
				}
				
				self.updateData(on: self.followers)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	func configureDataSource() {
		self.dataSource = UICollectionViewDiffableDataSource<Section,  Follower>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		})
	}
	
	func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
	
	@objc func addButtonTapped() {
		self.showLoadingView()
		
		NetworkManager.shared.getUserInfo(for: self.username) { [weak self](result) in
			guard let self = self else { return }
			
			self.dismissLoadingView()
			
			switch result {
			case .success(let user):
				
				let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
				
				PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] (error) in
					guard let self = self else { return }
					
					guard let error = error else {
						self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited", buttonTitle: "Ok")
						return
					}
					
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
				}
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		if offsetY > contentHeight - height {
			guard hasMoreFollowers else { return }
			self.page += 1
			self.getFollowers(username: self.username, page: self.page)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let activeArray = self.isSearching ? self.filteredFollowers : self.followers
		
		let follower = activeArray[indexPath.item]
		
		let destVC = UserInfoVC()
		destVC.username = follower.login
		destVC.delegate = self
		let navController = UINavigationController(rootViewController: destVC)
		
		self.present(navController, animated: true)
		
	}
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
		
		self.isSearching = true
		
		self.filteredFollowers = self.followers.filter { $0.login.lowercased().contains(filter.lowercased())}
		
		self.updateData(on: self.filteredFollowers)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.isSearching = false
		self.updateData(on: self.followers)
	}
}

extension FollowerListVC: FollowerListVCDelegate {
	func didRequestFollowers(for username: String) {
		self.username = username
		self.title = username
		self.page = 1
		
		self.followers.removeAll()
		self.filteredFollowers.removeAll()
		
		self.collectionView.setContentOffset(.zero, animated: true)
		self.getFollowers(username: username, page: page)
	}
}

