//
//  XMarkButtonView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 7/4/22.
//

import SwiftUI

struct XMarkButtonView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            // this will dismiss the sheet
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark").font(.headline)
        })
    }
}

struct XMarkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButtonView()
    }
}
