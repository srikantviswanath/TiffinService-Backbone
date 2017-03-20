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
    
    var viewModel: TransactionVM!
    
    func writeToDB() {
        let transactionJSON = Mapper().toJSON(self.viewModel.model)
        TransactionNetworker.REF_TRANSACTIONS.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(self.viewModel.userId) {
                TransactionNetworker.REF_TRANSACTIONS.child(self.viewModel.userId).updateChildValues(
                    [self.viewModel.id: transactionJSON]
                )
            } else {
                TransactionNetworker.REF_TRANSACTIONS.updateChildValues(
                    [self.viewModel.userId: [self.viewModel.id: transactionJSON]]
                )
            }
        })
    }
}
