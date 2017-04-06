//
//  TransactionService.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/19/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

struct TransactionNetworker {
    
    static var REF_TRANSACTIONS = FIRDatabase.database().reference().child("Transactions")
    
    func writeToDB(model: Transaction, completed: @escaping ()->()) {
        let transactionJSON = Mapper().toJSON(model)
        TransactionNetworker.REF_TRANSACTIONS.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(model.userId) {
                TransactionNetworker.REF_TRANSACTIONS.child(model.userId).updateChildValues(
                    [model.id: transactionJSON]
                ){_,_ in completed()}
            } else {
                TransactionNetworker.REF_TRANSACTIONS.updateChildValues(
                    [model.userId: [model.id: transactionJSON]]
                ){_,_ in completed()}
            }
        })
    }
}
