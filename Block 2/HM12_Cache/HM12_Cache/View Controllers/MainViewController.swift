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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        
        NetworkManager.shared.fetchInfoCharacter(from: API.urlCharacter.rawValue) { infoCharacter in
            self.countCharacters = infoCharacter.info?.count
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return countCharacters ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = indexPath.row

        NetworkManager.shared.fetchCharacter(from: API.urlCharacter.rawValue + String(index + 1)) { character in
            cell.textLabel?.text = character.name ?? ""
        }
        return cell
    }
}

