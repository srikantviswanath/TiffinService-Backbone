//
//  BalanceNetworker.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/19/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

struct BalanceNetworker {
    
    static var REF_BALANCES = FIRDatabase.database().reference().child("Balances")
    
    var viewModel: BalanceVM!
    
    static func getBalancePerUser(userId: String, userFN: String = "", userLN: String = "", completed: @escaping (BalanceVM)->()) {
        REF_BALANCES.child(userId).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                let balanceObj = Mapper<Balance>().map(JSON: snapshot.value as! [String: Any])!
                let balanceVM = BalanceVM(balance: balanceObj)
                balanceVM.model.userId = snapshot.key
                completed(balanceVM)
            } else {
                let balanceVM = BalanceVM(userId: userId, userFN: userFN, userLN: userLN)
                completed(balanceVM)
            }
        })
    }
    
    func writeToDB() {
        let balanceJSON = Mapper().toJSON(self.viewModel.model)
        BalanceNetworker.REF_BALANCES.child(self.viewModel.userId).observeSingleEvent(of: .value, with: { balanceSS in
            if balanceSS.exists() {
                BalanceNetworker.REF_BALANCES.child(self.viewModel.userId).updateChildValues(balanceJSON)
            } else {
                BalanceNetworker.REF_BALANCES.updateChildValues([self.viewModel.userId: balanceJSON])
            }
        })
    }
}