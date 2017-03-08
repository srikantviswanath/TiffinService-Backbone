//
//  MenuItemUpload.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/25/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import UIKit
import ObjectMapper

class MenuItemUpload: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ItemNameField: UITextField!
    @IBOutlet weak var ItemDescriptionField: UITextField!
    @IBOutlet weak var ItemPriceField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ItemPriceField.delegate = self
        self.ItemDescriptionField.delegate = self
        self.ItemNameField.delegate = self
    }
    
    @IBAction func uploadBtnPressed(sender: UIButton) {
        if (self.ItemNameField.text != "") && (self.ItemPriceField.text != "") && (self.ItemDescriptionField.text != "") {
            let newMenuItem = MenuInventoryVM(
                name: self.ItemNameField.text!, price: Int(self.ItemPriceField.text!)!,
                description: self.ItemDescriptionField.text!
            )
            newMenuItem.writeToDB() {
                self.performSegue(withIdentifier: "NewItemToInventory", sender: nil)
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

}
