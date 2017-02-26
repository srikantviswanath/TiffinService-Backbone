//
//  MenuInventoryVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/24/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit

class MenuInventoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var inventoryTable: UITableView!
    
    var inventoryList = [MenuItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        inventoryTable.delegate = self
        inventoryTable.dataSource = self
        MenuItem.getAll() { fetchedItems in
            self.inventoryList = fetchedItems
            self.inventoryTable.reloadData()
        }

    }
    
    @IBAction func uploadItemBtnClicked(sender: UIButton) {
        performSegue(withIdentifier: "InventoryToUpload", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inventoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = inventoryTable.dequeueReusableCell(withIdentifier: "MenuItemCell") as? MenuItemCell{
            cell.configureCell(menuItem: inventoryList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
