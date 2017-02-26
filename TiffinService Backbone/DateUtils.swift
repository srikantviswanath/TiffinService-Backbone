//
//  DateUtils.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 2/26/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation

///Return current date in mm-dd-yyyy format
func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    return formatter.string(from: date)
}
