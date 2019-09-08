//
//  ViewController.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableViewController: UITableView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: -
    
    private lazy var dataManager = {
        return DataManager(baseURL: API.AuthenticatedBaseURL)
    }()
    
    // MARK: -
    
    var viewModel: HomeViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchRedditData()
        
        self.title = "Swift News"
        
        homeTableViewController.dataSource = self
        
        let nibName = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableViewController.register(nibName, forCellReuseIdentifier: "tableViewCell")
        
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        
        messageLabel.isHidden = true
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        
        setupTableView()
        setupRefreshControl()
    }
    
    func reloadData() {
        updateView()
    }
    
    private func updateView() {
        activityIndicatorView.stopAnimating()
        homeTableViewController.refreshControl?.endRefreshing()
        
        if let _ = viewModel {
            updateRedditData()
            
        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Data currently unavailable, please try again later. Thank you !."
        }
    }
    
    // MARK: - Setups
    
    private func setupTableView() {
        homeTableViewController.separatorInset = UIEdgeInsets.zero
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(HomeViewController.didRefresh(sender:)), for: .valueChanged)
        
        homeTableViewController.refreshControl = refreshControl
    }
    
    // MARK: -
    
    private func updateRedditData() {
        homeTableViewController.reloadData()
    }
    
    fileprivate func fetchRedditData() {
        dataManager.redditData() { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                self.viewModel = HomeViewModel(children:  response.listData?.children ?? [])
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func didRefresh(sender: UIRefreshControl) {
        fetchRedditData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfChildren
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! HomeTableViewCell
        
        let title = viewModel?.children[indexPath.row].dataChildren?.title ?? ""
        let image = viewModel?.children[indexPath.row].dataChildren?.thumbnail ?? ""
        
        cell.homeCellInit(image, title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.titleReddit = viewModel?.children[indexPath.row].dataChildren?.title ?? ""
        vc.descriptionReddit = viewModel?.children[indexPath.row].dataChildren?.selftext ?? ""
        vc.imageURL = viewModel?.children[indexPath.row].dataChildren?.thumbnail ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
