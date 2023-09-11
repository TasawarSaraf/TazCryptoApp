//
//  Statistic Model.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 7/3/22.
//

import Foundation

// we will use for each
struct StatisticModel: Identifiable{
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    // we can set default
    init(title: String, value: String, percentageChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
