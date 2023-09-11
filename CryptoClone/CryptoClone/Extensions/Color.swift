//
//  Color.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/26/22.
//

import Foundation
import SwiftUI


// Extending the color class

extension Color{

    // from the SwiftUI module we extended the Color struct to also add these themes to it
    static let theme = ColorTheme()
}


struct ColorTheme{
    // these colors are coming from the asset folders both conforming to light and dark mode
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
