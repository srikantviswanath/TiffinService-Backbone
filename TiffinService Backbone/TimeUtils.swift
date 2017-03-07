//
//  TimeUtils.swift
//  TiffinService Backbone
//
//  Created by Srikant Viswanath on 3/6/17.
//  Copyright © 2017 Srikant Viswanath. All rights reserved.
//

import Foundation

func getCurrentTime() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    return formatter.string(from: Date())
}
