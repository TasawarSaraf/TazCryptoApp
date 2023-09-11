//
//  UIApplication.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/29/22.
//

import Foundation
import SwiftUI


extension UIApplication{
    func endEditing(){
        // stack overflow
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
