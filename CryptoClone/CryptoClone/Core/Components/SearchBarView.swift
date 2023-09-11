//
//  SearchBarView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/29/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(
                searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                
            )
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
            // since crypto are prolly not part of the english dictionary
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .offset(x: 10)
                    .foregroundColor(Color.theme.accent).onTapGesture {
                        // this will erase the text
                        // if we click on the close button it will also bring down the keyboard
                        UIApplication.shared.endEditing()
                        searchText = ""
                    },
                alignment: .trailing
            
            )
        }.font(.headline).padding().background(RoundedRectangle(cornerRadius: 25).fill(Color.theme.background).shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)).padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
