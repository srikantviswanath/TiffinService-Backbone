//
//  BaseModel.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/6/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation

class MenuItemCore {
    
    var itemID: String!
    var name: String!
    var price: Int!
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

protocol Networker {
    var delegate: NetworkingVC?{get set}
}

protocol NetworkDelegate {
    func didFinishNetworkCall()
}

protocol NetworkingVC: NetworkDelegate {
    var networker: Networker {get set}
}
