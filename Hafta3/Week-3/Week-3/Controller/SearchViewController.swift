//
//  SearchViewController.swift
//  Week-3
//
//  Created by Kerim Caglar on 3.07.2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var users = [User]()
    var filteredUsers = [User]()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Search"
        
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))
        
        guard let users = userList else { return }
        self.users = users
        
        tableView.dataSource = self
        configureSearchController()
    }
    
    private func configureSearchController() {
        
        searchController.searchBar.placeholder = "Search User"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContextForSearchText(searchText: String) {
        filteredUsers = users.filter({ (user: User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
}


// TableView Extensions
extension SearchViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredUsers.count
        }
        
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        let user: User
        
        if isFiltering {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.company.name
        
        return cell!
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //TODO:
        let searchBar = searchController.searchBar
        filterContextForSearchText(searchText: searchBar.text!)
    }
    
}
