//
//  CoinRowView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/27/22.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0){
            leftColumn
            Spacer()
            
            if showHoldingsColumn{
               centerColumn
            }
            rightColumn
        }.font(.subheadline).padding()
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        // from the extension
        
        Group{
            CoinRowView(coin: dev.coin, showHoldingsColumn: true).previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingsColumn: true).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
        
        
        
    }
}


extension CoinRowView{
    private var leftColumn: some View{
        HStack(spacing: 0){
            Text("\(coin.rank)").font(.caption).foregroundColor(Color.theme.secondaryText).frame(minWidth: 30)
            
            CoinImageView(coin: coin).frame(width:30, height: 30)
            
            Text(coin.symbol.uppercased()).font(.headline).padding(.leading, 6).foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View{
        VStack{
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
        }.foregroundColor(Color.theme.accent)
    }
    
    
    private var rightColumn: some View{
        VStack(alignment: .trailing){
            // positvie it will be green, negative will be red
            Text(coin.currentPrice.asCurrencyWith6Decimals())
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }.frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
