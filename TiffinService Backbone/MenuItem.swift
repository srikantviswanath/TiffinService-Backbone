//
//  MenuItem.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/22/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper


class MenuItem: Mappable {
    static var REF = FIRDatabase.database().reference().child("MenuItems")
    var id: String!
    var name: String!
    var description: String!
    var price: Int!
    
   /* init(id: String, name: String, desc: String, price: Int) {
        self.id = id
        self.name = name
        self.description = desc
        self.price = price
    }*/
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["Name"]
        description <- map["Description"]
        price <- map["Price"]
    }
    
    static func getAll(completion: @escaping ([MenuItem]) -> ()) {
        var menuItemsFetched = [MenuItem]()
        REF.observeSingleEvent(of: .value, with: { menuItemsSS in
            if let jsonItems = menuItemsSS.children.allObjects as? [FIRDataSnapshot] {
                for jsonItem in jsonItems {
                    var menuItem = Mapper<MenuItem>().map(JSON: jsonItem.value as! [String: Any])!
                    menuItem.id = jsonItem.key
                    menuItemsFetched.append(menuItem)
                }
                completion(menuItemsFetched)
            }
        })
    }
}
