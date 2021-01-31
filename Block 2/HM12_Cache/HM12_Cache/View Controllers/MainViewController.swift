//
//  MainViewController.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 24.01.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    // MARK: - Private properties
    private var countPages: Int?
    private var currentPage = 1
    private var cellStep = 20
    private var characters = [Result?]()
    private var dataTasks = [URLSessionDataTask?]()

    private var searchName: String?
    private var countPagesSearch: Int?
    private var currentPageSearch = 1
    private var cellStepSearch = 15
    private var charactersSearch = [Result?]()
    private var dataTasksSearch = [URLSessionDataTask?]()
    
    private let searchController = UISearchController(searchResultsController: nil)
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
        
        let dataTaskFromFirstPage = NetworkManager.shared.fetchCharacter(url: urlAPI.urlCharacter.rawValue, page: currentPage, dataTasks: dataTasks) { [self] infoCharacter in
            
            guard let results = infoCharacter?.results else { return }
            countPages = infoCharacter?.info?.pages
            characters.append(contentsOf: results)
            currentPage = currentPage + 1
            tableView.reloadData()
        }
        dataTasks.append(dataTaskFromFirstPage)
        setupSearchController()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let index = indexPath.row
        let detailCharacterVC = segue.destination as! DetailCharacterViewController
        detailCharacterVC.characterID = isFiltering ? charactersSearch[index] : characters[index]
    }
    
    private func prefetchCharactersFromNextPages() {
        if currentPage - 1 == countPages { return }

        let dataTaskFromPage = NetworkManager.shared.fetchCharacter(url: urlAPI.urlCharacter.rawValue, page: currentPage, dataTasks: dataTasks) { [self] infoCharacter in
            
            guard let results = infoCharacter?.results else { return }
            
            var indexPathsOptional = [IndexPath?]()
            characters.append(contentsOf: results)
            currentPage = currentPage + 1
            
            for index in results {
                indexPathsOptional.append(IndexPath(row: (index.id!) - 1, section: 0))
            }
            
            let indexPaths = indexPathsOptional.compactMap { $0 }
            tableView.performBatchUpdates {
                tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
        dataTasks.append(dataTaskFromPage)
    }
    
    private func prefetchForSearchCharactersFromNextPages(searchText: String) {
        if currentPageSearch - 1 == countPagesSearch { return }

        let dataTaskFromPage = NetworkManager.shared.fetchCharacter(url: urlAPI.urlCharacter.rawValue, page: currentPageSearch, name: searchText, dataTasks: dataTasksSearch) { [self] infoCharacter in
            
            guard let results = infoCharacter?.results else { return }
            
            var indexPathsOptional = [IndexPath?]()
            for (key, _) in results.enumerated() {
                indexPathsOptional.append(IndexPath(row: charactersSearch.count + key, section: 0))
            }
            charactersSearch.append(contentsOf: results)
            currentPageSearch = currentPageSearch + 1
            
            let indexPaths = indexPathsOptional.compactMap { $0 }
            
            tableView.performBatchUpdates {
                tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
        dataTasksSearch.append(dataTaskFromPage)
    }
    
    private func updateStepForMainList(index: Int) {
        if (index + 1) % cellStep == 0 {
            prefetchCharactersFromNextPages()
            cellStep = cellStep + 20
        }
    }
    
    private func updateStepForSearchList(index: Int) {
        if (index + 1) % cellStepSearch == 0 {
            prefetchForSearchCharactersFromNextPages(searchText: searchName!)
            cellStepSearch = cellStepSearch + 20
        }
    }
}

// MARK: - Table view data source
extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? charactersSearch.count : characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterCell
        let index = indexPath.row
        
        let result = isFiltering ? charactersSearch[index] : characters[index]
        cell.configureCell1(with: result)
        isFiltering ? updateStepForSearchList(index: index) : updateStepForMainList(index: index)
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
        searchName = searchController.searchBar.text
        filterCharacterForSearchText(searchName!)
    }
    
    private func clearSearch() {
        countPagesSearch = nil
        currentPageSearch = 1
        cellStepSearch = 20
        charactersSearch.removeAll()
        dataTasksSearch.removeAll()
        tableView.reloadData()
    }
    
    private func filterCharacterForSearchText(_ searchText: String) {
        clearSearch()
        
        if searchText == "" { return }
        
        let dataTaskFromFirstPageSearch = NetworkManager.shared.fetchCharacter(url: urlAPI.urlCharacter.rawValue, page: currentPageSearch, name: searchText, dataTasks: dataTasksSearch) { [self] infoCharacter in

            guard let results = infoCharacter?.results else { return }
            countPagesSearch = infoCharacter?.info?.pages
            charactersSearch.append(contentsOf: results)
            currentPageSearch = currentPageSearch + 1
            tableView.reloadData()
        }
        dataTasksSearch.append(dataTaskFromFirstPageSearch)
    }
}

