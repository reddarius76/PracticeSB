//
//  MainViewController.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 24.01.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    // MARK: - Private properties
    private var countCharacters: Int?
    private let searchController = UISearchController(searchResultsController: nil)
    private var characterInfo: CharacterInfo?
    private var filteredChracter = [Result]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 58
        
        URLCache.shared.diskCapacity = 52428800
        //URLCache.shared.removeAllCachedResponses()
        
        NetworkManager.shared.fetchInfoCharacter(from: urlAPI.urlCharacter.rawValue) { [self] infoCharacter in
            self.countCharacters = infoCharacter.info?.count
            self.tableView.reloadData()
        }
        
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let characterID = indexPath.row + 1
        let detailCharacterVC = segue.destination as! DetailCharacterViewController
        detailCharacterVC.characterID = characterID
    }
}

// MARK: - Table view data source
extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCharacters ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterCell
        let index = indexPath.row
        
        NetworkManager.shared.fetchCharacter(from: urlAPI.urlCharacter.rawValue + String(index + 1)) { character in
            cell.configureCell(with: character)
        }
                    
        return cell
    }
}


//MARK: - UISearchResults
extension MainViewController: UISearchResultsUpdating {
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .label
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}

