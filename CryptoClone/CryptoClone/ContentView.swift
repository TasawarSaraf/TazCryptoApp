//
//  ContentView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/26/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            
            VStack{
                Text("Accent Color").foregroundColor(Color.theme.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
