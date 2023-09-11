//
//  CryptoCloneApp.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/26/22.
//

import SwiftUI

@main
struct CryptoCloneApp: App {
    
    
    @StateObject var vm = HomeViewModel()
    
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            // we are going to be navigating through the pages so good to have Navigation View set up from the beginning
            NavigationView{
                // we will also build a custom navigation bar so hide the current default one
                HomeView().navigationBarHidden(true)
            }
            .environmentObject(vm) // now made it environment object
        }
    }
}
