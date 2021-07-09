//
//  ViewController.swift
//  Week-3
//
//  Created by Kerim Caglar on 3.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    var filteredUsers = [User]()
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))
        
        guard let users = userList else { return }
        self.users = users
        
        tableView.dataSource = self
        
    }
}

// TableView Extensions
extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            if filteredUsers.count == 0 {
                //self.tableView.setEmptyMessage("Aradağınız kişi bulunamadı 😢.", "person.2")
                showEmptyStateView(in: view)
                
                self.tableView.separatorStyle = .none
            }else {
                restoreTableview()
                
            }
            return filteredUsers.count
            
        }
        restoreTableview()
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
    
    func showEmptyStateView(in view: UIView){
        let emtyStateView = EmptyStateVC(message: "Aradağınız kişi bulunamadı 😢.", image: UIImage(systemName: "person.2")!)
        //let emtyStateView = EmptyStateVC(message: "Açık restorant bulunamadı 🍽🥣.", image: UIImage(named: "empty")!)
        self.tableView.backgroundView = emtyStateView
    }
    
    func restoreTableview(){
        self.tableView.backgroundView = nil
        self.tableView.separatorStyle = .singleLine
    }
}

// SearchBar Extension
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredUsers = users.filter({ (user: User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        
        isFiltering = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

//MARK: Custom Empty View Oluşturunuz... 

