//
//  CoinImageView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/28/22.
//

import SwiftUI



struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel){
        // reference state object
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack{
            // when loaded load the image
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading{
                // image is loading
                ProgressView()
            } else{
                // image has not loading
                Image(systemName: "questionmark").foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin).previewLayout(.sizeThatFits).padding()
    }
}
