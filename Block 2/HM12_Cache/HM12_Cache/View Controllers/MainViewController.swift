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
        tableView.rowHeight = 58
        
        URLCache.shared.diskCapacity = 52428800
        //URLCache.shared.removeAllCachedResponses()
        
        NetworkManager.shared.fetchInfoCharacter(from: urlAPI.urlCharacter.rawValue) { infoCharacter in
            self.countCharacters = infoCharacter.info?.count
            self.tableView.reloadData()
        }
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
        
//        let infoCacheUsage = """
//            index: \(index + 1)
//            currentDiskUsage: \(URLCache.shared.currentDiskUsage / 1024) kb
//            currentMemoryUsage: \(URLCache.shared.currentMemoryUsage / 1024) kb
//            diskCapacity: \(URLCache.shared.diskCapacity / 1024) kb
//            memoryCapacity: \(URLCache.shared.memoryCapacity / 1024) kb
//            ---------------
//        """
//        print(infoCacheUsage)
            
        return cell
    }
}

