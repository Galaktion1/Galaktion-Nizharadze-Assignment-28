//
//  ViewController.swift
//  Galaktion Nizharadze, Assignment #28
//
//  Created by Gaga Nizharadze on 30.08.22.
//

import UIKit

class MainViewController: UIViewController {
        
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
    
    let viewModel = MainViewViewModel()
    
    private struct UIConstants {
        static let searchBarAndTableViewX: CGFloat = 0
        static let searchBarY: CGFloat = 180
        static let searchBarAndTableViewWidth: CGFloat = UIScreen.main.bounds.width
        static let searchBarHeight: CGFloat = 50
        
        static let tableViewY: CGFloat = 230
        static let tableViewHeight: CGFloat = UIScreen.main.bounds.height - 180
    }
    
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search here..."
        bar.frame = CGRect(x: UIConstants.searchBarAndTableViewX,
                           y: UIConstants.searchBarY,
                           width: UIConstants.searchBarAndTableViewWidth,
                           height: UIConstants.searchBarHeight)
        return bar
    }()
    
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: UIConstants.searchBarAndTableViewX,
                                 y: UIConstants.tableViewY,
                                 width: UIConstants.searchBarAndTableViewWidth,
                                 height: UIConstants.tableViewHeight)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confNavigationControllerAndViewSubviews()
        loadData()
        tableViewAndSearchbarDelegateConform()
    }
    
    func loadData() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func confNavigationControllerAndViewSubviews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Countries"
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
    
    private func tableViewAndSearchbarDelegateConform() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfRowsInSection() > 0 {
            activityIndicator.stopAnimating()
        }
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.cellForRowAt()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WeatherDetailsViewController()
        vc.data = viewModel.didSelectRowAt()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if !searchText.isEmpty {
            activityIndicator.startAnimating()
            viewModel.fetchWeather(countryName: searchText)
        }
        
        tableView.reloadData()
    }
}

