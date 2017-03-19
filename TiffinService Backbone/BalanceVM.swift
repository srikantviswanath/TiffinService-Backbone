//
//  BalanceVM.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/19/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import ObjectMapper

class BalanceVM {
    
    static var networkDelegate = BalanceNetworker.self
    
    var model: Balance!
    var userId: String {
        return self.model.userId
    }
    var currentBalance: String { //Logic to check if current loggedin user is Vendor or Client and return the appropriate prepended "owes/owed" string
        return "$" + "\(self.model.currentBalance)"
    }
    var userName: String {
        return self.model.userFirstName + ", " + self.model.userLastName
    }
    
    ///For creating instances after fetching underlying model from network
    init(balance: Balance) {
        self.model = balance
    }
    
    
    init() {
        
    }
}
