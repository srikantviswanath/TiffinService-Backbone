//
//  MenuForClientVC.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/27/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//
import UIKit

class MenuForClient: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTable: UITableView!
    
    var menuList = [MenuItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self
        PublishedMenuNetworker.getMenu() { publishedMenu in
            self.menuList = publishedMenu.menuItems
            self.menuTable.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = menuTable.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuItemCell{
            cell.configureCell(menuItem: menuList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
